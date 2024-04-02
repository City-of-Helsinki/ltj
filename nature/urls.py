#from django.conf.urls import url
from django.urls import re_path


from . import views

app_name = "nature"
urlpatterns = [
    re_path(
        r"^feature-report/(?P<pk>\d+)/$",
        views.FeatureReportView.as_view(),
        name="feature-report",
    ),
    re_path(
        r"^observationseries-report/(?P<pk>\d+)/$",
        views.ObservationSeriesReportView.as_view(),
        name="observationseries-report",
    ),
    re_path(
        r"^feature-observations-report/(?P<pk>\d+)/$",
        views.FeatureObservationsReportView.as_view(),
        name="feature-observations-report",
    ),
    re_path(
        r"^feature-habitattypeobservations-report/(?P<pk>\d+)/$",
        views.FeatureHabitatTypeObservationsReportView.as_view(),
        name="feature-habitattypeobservations-report",
    ),
    re_path(
        r"^species-report/(?P<pk>\d+)/$",
        views.SpeciesReportView.as_view(),
        name="species-report",
    ),
    re_path(
        r"^species-regulations-report/(?P<pk>\d+)/$",
        views.SpeciesRegulationsReportView.as_view(),
        name="species-regulations-report",
    ),
    re_path(
        r"^observation-report/(?P<pk>\d+)/$",
        views.ObservationReportView.as_view(),
        name="observation-report",
    ),
    re_path(r"^wfs", views.FeatureWFSView.as_view(), name="wfs"),
]
