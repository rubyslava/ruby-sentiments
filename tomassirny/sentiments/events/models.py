from django.conf import settings
from django.db import models


class Event(models.Model):
    """
    Basic properties of event
    """

    name = models.CharField(max_length=75)
    description = models.TextField(blank=True, null=True)
    date = models.DateField()
    from_time = models.TimeField()
    to_time = models.TimeField()


class Attendance(models.Model):
    """
    Joining model between user and event
    """

    user = models.ForeignKey(settings.AUTH_USER_MODEL)
    event = models.ForeignKey(Event)
    # other possible fields like 'Maybe' status, etc.
