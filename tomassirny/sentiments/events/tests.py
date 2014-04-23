from django.core.urlresolvers import reverse
from django.test import TestCase

from .models import Event, Attendance


class ListViewTests(TestCase):
    """
    Basic checks for view with events list
    """

    def setUp(self):
        self.event = Event.objects.create(
            name='Test meetup',
            description='Test description',
            date='2014-04-24',
            from_time='19:00',
            to_time='22:30'
        )

    def test_page_anonymous(self):
        response = self.client.get(reverse('events-list'))
        self.assertContains(response, 'meetup', count=1, status_code=200)
        self.assertContains(response, 'Join', count=1)

    def test_join(self):
        self.assertIsNone(self.client.session.get('username'))
        response = self.client.get(reverse('events-list'))
        self.assertContains(response, 'Join', count=1, status_code=200)

        response = self.client.get(
            reverse('event-join', kwargs={'event_id': self.event.id})
        )
        self.assertRedirects(
            response,
            reverse('events-list'),
            status_code=302,
            target_status_code=200
        )

        response = self.client.get(reverse('events-list'))
        self.assertContains(response, 'Attending', count=1, status_code=200)
        self.assertIsNotNone(self.client.session.get('username'))
