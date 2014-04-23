import hashlib
from datetime import datetime

from django.contrib.auth import get_user_model
from django.core.urlresolvers import reverse
from django.http import HttpResponseRedirect, Http404
from django.shortcuts import get_object_or_404
from django.views.generic import View, ListView

from .models import Event, Attendance


class EventsView(ListView):
    """
    List of events
    """
    model = Event

    def get_queryset(self):
        results = self.model.objects.extra(
            select={
                'attends': 'select count(a.user_id) '
                           'from events_attendance AS a '
                           'join auth_user AS u on (a.user_id=u.id) '
                           'where a.event_id=events_event.id AND u.username="{}"'.format(
                                self.request.session.get('username', None)
                            )
            }
        )
        return results


class AttendView(View):
    """
    Put user as attendee to given event
    """
    def get(self, request, *args, **kwargs):
        event = get_object_or_404(Event, pk=kwargs['event_id'])
        username = request.session.get('username', None)
        if not username:
            username = hashlib.sha1(datetime.now().isoformat()).hexdigest()
            request.session['username'] = username

        user, user_created = get_user_model().objects.get_or_create(
            username=username
        )
        attendance, attendance_created = Attendance.objects.get_or_create(
            user=user, event=event
        )

        return HttpResponseRedirect(reverse('events-list'))

