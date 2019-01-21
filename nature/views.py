import requests
from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.utils.decorators import method_decorator
from django.views import View
from django.views.generic import DetailView

from nature.hmac import HMACAuth
from .enums import UserRole
from .models import Feature, Species, ObservationSeries, Observation


class ProtectedReportViewMixin:
    """View mixin for protected reports

    Allow accessing all reports for staff users and public reports
    for non-staff users. If the requests is a hmac request, the
    reports are filtered based on forwarded authorization groups.
    """
    def get_queryset(self):
        qs = super().get_queryset()
        if self.request.user.is_staff:
            return qs

        hmac_auth = self._get_hmac_auth()
        if hmac_auth.has_admin_group:
            return qs.for_admin()
        elif hmac_auth.has_office_hki_group:
            return qs.for_office_hki()
        elif hmac_auth.has_office_group:
            return qs.for_office()

        return qs.www()

    def get_context_data(self, **kwargs):
        context_data = super().get_context_data(**kwargs)

        hmac_auth = self._get_hmac_auth()
        user_role = UserRole.ADMIN if self.request.user.is_staff else hmac_auth.user_role
        context_data['user_role'] = user_role.value

        return context_data

    def _get_hmac_auth(self):
        if not hasattr(self, '_hmac_auth'):
            self._hmac_auth = HMACAuth(self.request)
        return self._hmac_auth


class FeatureReportView(ProtectedReportViewMixin, DetailView):
    queryset = Feature.objects.all()
    template_name = 'nature/reports/feature-report.html'


class ObservationReportView(ProtectedReportViewMixin, DetailView):
    queryset = Observation.objects.all()
    template_name = 'nature/reports/observation-report.html'


class SpeciesReportView(ProtectedReportViewMixin, DetailView):
    queryset = Species.objects.all()
    template_name = 'nature/reports/species-report.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        if self.object:
            context['observations'] = self.get_observations()
        return context

    def get_observations(self):
        hmac_auth = self._get_hmac_auth()
        qs = self.object.observations.all()
        if self.request.user.is_staff or hmac_auth.has_admin_group:
            qs = qs.for_admin()
        elif hmac_auth.has_office_hki_group:
            qs = qs.for_office_hki()
        elif hmac_auth.has_office_group:
            qs = qs.for_office()
        else:
            qs = qs.www()
        return qs.select_related('feature__feature_class').order_by('feature__feature_class__name')


class SpeciesRegulationsReportView(ProtectedReportViewMixin, DetailView):
    queryset = Species.objects.all()
    template_name = 'nature/reports/species-regulations-report.html'


class ObservationSeriesReportView(DetailView):
    queryset = ObservationSeries.objects.all()
    template_name = 'nature/reports/observationseries-report.html'


class FeatureObservationsReportView(ProtectedReportViewMixin, DetailView):
    queryset = Feature.objects.all()
    template_name = 'nature/reports/feature-observations-report.html'

    def get_context_data(self, **kwargs):
        context_data = super().get_context_data(**kwargs)
        if self.object:
            context_data['feature_observations'] = self.get_observations()
        return context_data

    def get_observations(self):
        hmac_auth = self._get_hmac_auth()
        qs = self.object.observations.all()
        if self.request.user.is_staff or hmac_auth.has_admin_group:
            qs = qs.for_admin()
        elif hmac_auth.has_office_hki_group:
            qs = qs.for_office_hki()
        elif hmac_auth.has_office_group:
            qs = qs.for_office()
        else:
            qs = qs.www()
        return qs.order_by('species__name_fi')


class FeatureHabitatTypeObservationsReportView(ProtectedReportViewMixin, DetailView):
    queryset = Feature.objects.all()
    template_name = 'nature/reports/feature-habitattypeobservations-report.html'


@method_decorator(login_required, name='dispatch')
class FeatureWFSView(View):

    def get(self, request, *args, **kwargs):
        url = self._get_wfs_url()
        r = requests.get(url)
        return HttpResponse(
            content=r.content,
            content_type=r.headers['content-type'],
            status=r.status_code,
        )

    def _get_wfs_url(self):
        query_dict = self.request.GET.copy()
        query_dict.setlist('typeName', [self._get_layer_typename()])
        return '{0}?{1}'.format(settings.WFS_SERVER_URL, query_dict.urlencode())

    def _get_layer_typename(self):
        return '{0}:{1}'.format(settings.WFS_NAMESPACE, self.request.GET.get('typeName'))
