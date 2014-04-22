from django.conf.urls import patterns, include, url

from .views import Events

urlpatterns = patterns('',
    url(r'', Events.as_view(), name='events-list'),
)

