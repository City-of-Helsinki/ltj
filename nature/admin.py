from django.contrib.gis import admin
from django.utils.translation import gettext_lazy as _
from django.utils.html import format_html
from django.urls import reverse

from .models import (
    Feature,
    FeatureClass,
    FeatureLink,
    FeaturePublication,
    Observation,
    ObservationSeries,
    Publication,
    Species,
    LinkType,
    HabitatType,
    Regulation,
    Value,
    Transaction,
    Person,
    FeatureValue,
    TransactionFeature,
    HabitatTypeObservation,
    Protection,
    Square,
    SpeciesRegulation,
    HabitatTypeRegulation,
    TransactionRegulation,
)
from .forms import (
    FeatureForm,
    HabitatTypeObservationInlineForm,
    ProtectionInlineForm,
    SquareInlineForm,
    ValueForm,
    ObservationSeriesForm,
    PersonForm,
    PublicationForm,
    FeatureLinkForm,
    ObservationForm,
    SpeciesForm,
    LinkTypeForm,
    HabitatTypeForm,
    RegulationForm,
    FeatureClassForm,
    TransactionForm,
)
from .widgets import NatureOLWidget


class SpeciesRegulationInline(admin.TabularInline):
    model = SpeciesRegulation


class HabitatTypeRegulationInline(admin.TabularInline):
    model = HabitatTypeRegulation


class TransactionRegulationInline(admin.TabularInline):
    model = TransactionRegulation


@admin.register(Species)
class SpeciesAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "name_fi",
        "name_sci_1",
        "name_subspecies_1",
        "code",
        "report",
    )
    search_fields = ("name_fi", "name_sci_1", "name_subspecies_1", "code", "id")
    list_filter = ("taxon", "taxon_1")
    actions = None
    form = SpeciesForm
    change_form_template = "admin/species.html"

    def report(self, obj):
        url = reverse("nature:species-report", kwargs={"pk": obj.id})
        return format_html(
            '<a target="_blank" href="{0}">{1}</a>'.format(url, _("Species report"))
        )

    report.allow_tags = True
    report.short_description = _("Species report")

    inlines = [
        SpeciesRegulationInline,
    ]


@admin.register(ObservationSeries)
class ObservationSeriesAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "valid")
    search_fields = ("name",)
    form = ObservationSeriesForm
    actions = None


class ObservationInline(admin.TabularInline):
    model = Observation
    fields = (
        "species",
        "series",
        "date",
        "observer",
        "quantity",
        "description",
        "notes",
        "protection_level",
        "migration_class",
        "occurrence",
        "origin",
    )
    raw_id_fields = ("species",)
    extra = 1
    form = ObservationForm

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        return qs.select_related("species", "series")


@admin.register(LinkType)
class LinkTypeAdmin(admin.ModelAdmin):
    list_display = ("id", "name")
    actions = None
    form = LinkTypeForm


class FeatureLinkInline(admin.TabularInline):
    model = FeatureLink
    fields = ("link", "text", "link_text", "link_type", "ordering", "protection_level")
    extra = 1
    form = FeatureLinkForm


@admin.register(FeatureClass)
class FeatureClassAdmin(admin.ModelAdmin):
    readonly_fields = ("super_class",)
    list_display = ("id", "name", "www", "open_data")
    search_fields = ("name",)
    actions = None
    form = FeatureClassForm


@admin.register(Publication)
class PublicationAdmin(admin.ModelAdmin):
    list_display = ("id", "publication_type", "name", "year")
    search_fields = ("name",)
    list_filter = ("publication_type", "year")
    actions = None
    form = PublicationForm

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        return qs.select_related("publication_type")


class FeaturePublicationInline(admin.TabularInline):
    model = FeaturePublication
    raw_id_fields = ("publication",)
    extra = 1


class FeatureValueInline(admin.TabularInline):
    model = FeatureValue
    raw_id_fields = ("value",)
    extra = 1


class TransactionFeatureInline(admin.TabularInline):
    verbose_name = _("Feature transaction")
    verbose_name_plural = _("Feature transactions")
    model = TransactionFeature
    raw_id_fields = ("transaction",)
    extra = 1


class HabitatTypeObservationInline(admin.TabularInline):
    model = HabitatTypeObservation
    form = HabitatTypeObservationInlineForm
    fields = ("habitat_type", "group_fraction", "observation_series", "additional_info")
    extra = 1


class ProtectionInline(admin.StackedInline):
    verbose_name = _("protection")
    verbose_name_plural = _(
        "protection"
    )  # protection has one to one relationship to feature
    model = Protection
    form = ProtectionInlineForm
    max_num = 1


class SquareInline(admin.StackedInline):
    verbose_name = _("square")
    verbose_name_plural = _("square")
    model = Square
    form = SquareInlineForm
    max_num = 1


@admin.register(Feature)
class FeatureAdmin(admin.ModelAdmin):
    readonly_fields = (
        "_area",
        "created_by",
        "created_time",
        "last_modified_by",
        "last_modified_time",
    )
    list_display = ("id", "feature_class", "fid", "name", "report", "active")
    search_fields = ("feature_class__name", "name", "fid", "id")
    list_filter = ("feature_class", "active")
    form = FeatureForm
    change_form_template = "admin/feature.html"
    inlines = [
        ObservationInline,
        FeatureLinkInline,
        FeaturePublicationInline,
        FeatureValueInline,
        TransactionFeatureInline,
        HabitatTypeObservationInline,
        ProtectionInline,
        SquareInline,
    ]
    actions = None

    widget = NatureOLWidget
    map_template = "nature/openlayers-nature.html"

    def get_queryset(self, request):
        qs = super().get_queryset(request)
        return qs.select_related("feature_class")

    def save_model(self, request, obj, form, change):
        if not obj.pk:
            obj.created_by = request.user.username
        obj.last_modified_by = request.user.username
        obj.save()

    def get_inline_instances(self, request, obj=None):
        inline_instances = super().get_inline_instances(request, obj)
        # Add all possible inlines by default and pop the ones that
        # are not required by type of the features. This way we makes
        # that all inlines can go through the processing done in base
        # class.
        *inline_instances, protection_inline, square_inline = inline_instances
        if obj and obj.is_protected:
            inline_instances.append(protection_inline)
        if obj and obj.is_square:
            inline_instances.append(square_inline)
        return inline_instances

    def get_fields(self, request, obj=None):
        form = self.get_form(request, obj, fields=None)
        # Move the feature class field to the beginning of the ordered dict
        if "feature_class" in form.base_fields:
            form.base_fields.move_to_end("feature_class", last=False)
        return list(form.base_fields) + list(self.get_readonly_fields(request, obj))

    # Return formatted area as area
    def _area(self, obj):
        return obj.formatted_area

    _area.short_description = Feature._meta.get_field("area").verbose_name

    def report(self, obj):
        url = reverse("nature:feature-report", kwargs={"pk": obj.id})
        return format_html(
            '<a target="_blank" href="{0}">{1}</a>'.format(url, _("Feature report"))
        )

    report.allow_tags = True
    report.short_description = _("Feature report")


@admin.register(HabitatType)
class HabitatTypeAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "code", "group")
    search_fields = ("id", "name", "code", "group", "additional_info")
    list_filter = ("group",)
    actions = None
    form = HabitatTypeForm

    inlines = [
        HabitatTypeRegulationInline,
    ]


@admin.register(Regulation)
class RegulationAdmin(admin.ModelAdmin):
    list_display = ("id", "name", "paragraph", "value", "value_explanation", "valid")
    search_fields = ("id", "name", "value", "value_explanation")
    list_filter = ("valid", "name")
    actions = None
    form = RegulationForm


@admin.register(Value)
class ValueAdmin(admin.ModelAdmin):
    list_display = ("id", "value", "explanation")
    search_fields = ("id", "value", "explanation")
    form = ValueForm
    actions = None


@admin.register(Transaction)
class TransactionAdmin(admin.ModelAdmin):
    list_display = ("id", "transaction_type", "description", "protection_level")
    search_fields = ("id", "description")
    list_filter = ("protection_level", "transaction_type")
    actions = None
    form = TransactionForm

    inlines = [TransactionRegulationInline]


@admin.register(Person)
class PersonAdmin(admin.ModelAdmin):
    exclude = ("notes", "company", "public_servant", "telephone", "email")
    list_display = ("id", "surname", "first_name")
    search_fields = ("id", "surname", "first_name")
    readonly_fields = ("created_time", "last_modified_time")
    actions = None
    form = PersonForm
