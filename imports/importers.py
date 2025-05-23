import os
import zipfile
from tempfile import gettempdir

from django.conf import settings
from django.contrib import messages
from django.contrib.gis.gdal import DataSource
from django.core.exceptions import ValidationError
from django.utils.translation import gettext_lazy as _

from nature.models import Feature, FeatureClass


SHAPEFILE_FIELD_MAPPING = {
    "id": "id",
    "tunnus": "fid",
    "luokkatunn": "feature_class_id",
    "nimi": "name",
    "kuvaus": "description",
    "huom": "notes",
    "voimassa": "active",
    "digipvm": "created_time",
    "numero": "number",
    "digitoija": "created_by",
    "suojaustas": "protection_level",
    "pvm_editoi": "last_modified_time",
    "muokkaaja": "last_modified_by",
    "pinta_ala": "area",
}


def active_value_processor(value):
    return value in ("t", 1)


# Some shapefile field values cannot be directly used as
# model field values. Those field values need to be
# processed before saving to model instances
FIELD_PROCESSORS = {"active": active_value_processor}


class ImportValidationError(ValidationError):
    pass


class ShapefileImporter:
    """
    A class that allow importing shapefile features to Feature model
    The class makes a few assumptions on the input shapefile:

    - The shapefile must be valid, i.e.
        - all mandatory files (.shp, .shx and .dbf) are present
        - all files have same name prefix
        - the number of shapes and records must match

    - The shapefile must not include additional fields besides the ones
    listed above and the names must match exactly. Basically they have
    same names as in database but shapefile has a 10 characters limit
    on field names.

    - The shapefile may omit some of the fields that are not required by
    the Feature model.

    - If a feature in shapefile has an id that already exists in database,
    then the importer will update the feature, otherwise it will create
    new ones.
    """

    error_messages = {
        "fields_not_allowed": _(
            "Fields not allowed: %(fields)s. Allowed shapefile fields are: %(allowed_fields)s."
        ),
        "feature_classes_not_exist": _(
            "Feature classes do not exist: %(feature_classes)s."
        ),
    }

    @classmethod
    def import_features(cls, zipped_shapefile):
        shapefile_importer = cls()
        shp = shapefile_importer._extract_shapefile(zipped_shapefile)
        data_source = DataSource(shp)
        layer = data_source[0]  # shapefile always have one layer
        shapefile_importer._validate_layer(layer)
        return shapefile_importer._import_layer(layer)

    def _extract_shapefile(self, zipped_shapefile):
        """
        Extract all files within zipped shapefile to the temporary directory

        :param zipped_shapefile: zipped shapefile
        :return: the path to the shapefile shp file
        """
        temp_dir = gettempdir()
        with zipfile.ZipFile(zipped_shapefile) as zip_ref:
            zip_ref.extractall(temp_dir)

        shapefile_name = next(
            (name for name in zip_ref.namelist() if name.endswith(".shp")), None
        )
        return os.path.join(temp_dir, shapefile_name)

    def _validate_layer(self, layer):
        """
        Validate feature data in shapefile layer

        :param layer: The shapefile data layer
        """
        self._validate_fields(layer)
        self._validate_feature_classes(layer)

    def _validate_fields(self, layer):
        """
        Validate layer fields

        :param layer: The layer to be validated
        :raise ImportValidationError: if invalid field found
        """
        fields_not_allowed = set(layer.fields) - set(SHAPEFILE_FIELD_MAPPING.keys())
        if fields_not_allowed:
            error_code = "fields_not_allowed"
            raise ImportValidationError(
                self.error_messages[error_code],
                code=error_code,
                params={
                    "fields": ", ".join(fields_not_allowed),
                    "allowed_fields": ", ".join(SHAPEFILE_FIELD_MAPPING.keys()),
                },
            )

    def _validate_feature_classes(self, layer):
        """
        Validate layer feature classes

        :param layer: The layer to be validated
        :raise ImportValidationError: if invalid feature class found
        """
        layer_feature_classes = set(layer.get_fields("luokkatunn"))
        db_feature_classes = set(
            FeatureClass.objects.filter(id__in=layer_feature_classes).values_list(
                "id", flat=True
            )
        )
        missing_feature_classes = layer_feature_classes - db_feature_classes
        if missing_feature_classes:
            error_code = "feature_classes_not_exist"
            raise ImportValidationError(
                self.error_messages[error_code],
                code=error_code,
                params={"feature_classes": ", ".join(missing_feature_classes)},
            )

    def _import_layer(self, layer):
        """
        Import features from shapefile layer

        :param layer: The layer from which the features are imported
        """
        import_log = []
        count = 0
        for feature in layer:
            feature_data = {}
            for shapefile_field in layer.fields:
                model_field = SHAPEFILE_FIELD_MAPPING.get(shapefile_field)
                if model_field:
                    processor = FIELD_PROCESSORS.get(model_field, lambda x: x)
                    feature_data[model_field] = processor(
                        feature[shapefile_field].value
                    )
            feature_id = feature_data.pop("id", None)
            geometry = feature.geom.geos
            # The geometries in shapefile must be using the same SRID as defined in settings
            geometry.srid = settings.SRID
            feature_data["geometry"] = geometry

            if feature_id:
                try:
                    feature = Feature.objects.get(id=feature_id)
                    for key, value in feature_data.items():
                        setattr(feature, key, value)
                    feature.save()
                    count += 1
                except Feature.DoesNotExist:
                    msg = _(
                        "Update feature failed: feature with id {0} does not exist"
                    ).format(feature_id)
                    import_log.append([messages.WARNING, msg])
            else:
                Feature.objects.create(**feature_data)
                count += 1

        msg = _("{0} features were imported").format(count)
        import_log.append([messages.SUCCESS, msg])
        return import_log
