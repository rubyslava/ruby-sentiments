# Django version of Ruby sentiments for Rubyslava/Pyvo meetup (Step 1)#

## Installation ##

This quick how-to expects existence of virtual environment (virtualenv)

* Download repo
```sh
git clone <url>
```

* Install dependencies
```shell
cd ruby-sentiments/tomassirny
pip install -U -r requirements.txt
cd sentiments
```

* Change settings (sentiments/sentiments/settings.py) if needed, (but working SQLite3 database is included)
in that case run this command first
```sh
./manage.py syncdb
```

## Running ##

* Start webserver
```sh
./manage.py runserver 8011
```

* Go to 'http://localhost:8011' in browser of your choice

## Behaviour ##

Right now the application starts at simple list of events. At each row (event) is 'Join' link which
signs user to the event. If user has already signed to event, link is replaces by 'Attending' label.
Information about user's events are preserved as long as user uses same browser
(sending same cookie to application).

## Design choices ##

### Structure ###
Project contains one Django application - _events_, others applications
(registration, events management, etc.) can be added later. This app
contains all code needed - models, views, html templates.

### Models ###
I chose 3 models for representing this domain - _Event_, _User_ (Django's native)
and _Attendance_. Attendance model works as joining table (_through_ field in Event model) - maps
many-to-many relation between events and users. It can contain other attributes
for this relation, e.g. status ('Going', 'Maybe', etc.).
To have this possibility from beginning, I created this model explicitly,
although Django can do it internally.
It also gives simpler ORM expressions:
```python
event.attendance_set.filter(user__username='Frantisek')
```

versus

```python
event.attendees.filter(username='Frantisek')
```

### Views ###
Application have 2 views - _EventsView_ and _AttendView_.
First one is simple list of existing events - extending Django's generic ListView
for listing of model's objects. This does some basic work for us (choosing default template,
populating context variables in template, etc.), but giving certain freedom, e.g. in filtering which
event to return by simply overriding _get_queryset()_ method.

Second view is based only on View class, requiring implementation of whole _get()_ method.
The code is pretty simple - selecting proper event and user and joining them together.
Now it only redirects back to _EventsView_. But it can be easily changed to handle Ajax
simply by replacing _get()_ method with _post()_ and adjusting format of response.

### User's persistance ###
New _User_ is created by each new visit to page (with clean server-based session,
distinguished by session cookie) - if _username_ key is not present in session.
Otherwise existing user is loaded. This approach is very simple and straight-forward, but serves
as good starting point and can be included in process of converging of anonymous user to registered
one (after implementing of registration/authentication).




