from django.shortcuts import render
from django.views.generic import ListView

from .models import Event


class Events(ListView):
    """
    List of events
    """
    model = Event


