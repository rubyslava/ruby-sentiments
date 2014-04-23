from django.conf.urls import patterns, include, url

from .views import EventsView, AttendView

urlpatterns = patterns('',
    url(r'^$', EventsView.as_view(), name='events-list'),
    url(r'^events/(?P<event_id>\d+)/$', AttendView.as_view(), name='events-list'),
)

