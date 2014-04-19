from collections import namedtuple


class Event:
    _event_id = None
    _name = None
    _description = None
    _start = None
    _end = None
    _attendees = []

    def __init__(self, event_id, name, description, start, end):
        self._event_id = event_id
        self._name = name
        self._description = description
        self._start = start
        self._end = end

    @property
    def event_id(self):
        return self._event_id

    @property
    def name(self):
        return self._name

    @property
    def description(self):
        return self._description

    @property
    def start(self):
        return self._start

    @property
    def end(self):
        return self._end

    def add_attendee(self, user):
        self._attendees.append(user)

EventListItem = namedtuple('EventListItem',[
    'event_id',
    'name',
    'description',
    'start',
    'end',
    'participants',
    'attended_by_current_user',
])


class User:
    _user_id = None
    _email = None

    def __init__(self, user_id, email):
        self._user_id = user_id
        self._email = email

    @property
    def user_id(self):
        return self._user_id

    @property
    def email(self):
        return self._email

    def attend(self, event):
        event.add_attendee(self)



class EventRepository:
    def list_events(self, current_user):
        raise NotImplementedError()

    def read_event(self, event_id):
        raise NotImplementedError()

    def create_event(self, name, description, start, end):
        raise NotImplementedError()

class UserRepository:
    def find_user_by_email(self, email):
        raise NotImplementedError()

    def create_user(self, email):
        raise NotImplementedError()
