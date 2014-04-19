from rsmt import utils
from rsmt.domain import EventRepository, UserRepository, Event, User, \
    EventListItem
from rsmt.utils import cached_property
import sqlalchemy as sa
import sqlalchemy.orm
from sqlalchemy.orm.scoping import scoped_session

metadata = sa.MetaData()

event_table = sa.Table(
    'events', metadata,
    sa.Column('event_id', sa.Integer, sa.Sequence('events_event_id_seq'),
              primary_key=True, autoincrement=True),
    sa.Column('name', sa.String),
    sa.Column('description', sa.String),
    sa.Column('start', sa.DateTime),
    sa.Column('end', sa.DateTime),
)

attendance_table = sa.Table(
    'event_attendance', metadata,
    sa.Column('event_id', None, sa.ForeignKey('events.event_id', ondelete='CASCADE'), primary_key=True),
    sa.Column('user_id', None, sa.ForeignKey('users.user_id', ondelete='CASCADE'), primary_key=True),
)

user_table = sa.Table(
    'users', metadata,
    sa.Column('user_id', sa.Integer, sa.Sequence('users_user_id_seq'), primary_key=True, autoincrement=True),
    sa.Column('email', sa.String, unique=True),
)

sa.orm.mapper(
    Event, event_table, column_prefix='_',
    properties={
        '_attendees': sa.orm.relationship(User, secondary=attendance_table)
    }
)
sa.orm.mapper(User, user_table, column_prefix='_')

class PgRepository:
    def __init__(self, session):
        self._session = session

    def _next_serial_id(self):
        return self._session.execute(self.id_column.default)

    @property
    def _query(self):
        return self._session.query(self.model)


class PgEventRepository(EventRepository, PgRepository):
    model = Event
    id_column = event_table.c.event_id
    def list_events(self, current_user):
        user_id = current_user.user_id if current_user else None

        if current_user:
            is_current_user = sa.func.max(
                sa.case([(attendance_table.c.user_id == user_id, 1)]))
        else:
            is_current_user = sa.literal(False)

        query = self._session.query(
            event_table.c.event_id,
            event_table.c.name,
            event_table.c.description,
            event_table.c.start,
            event_table.c.end,
            sa.func.count(attendance_table.c.user_id),
            is_current_user,
        )

        query = query.outerjoin(attendance_table)
        query = query.group_by(event_table.c.event_id)
        return [EventListItem(*row[:-1], attended_by_current_user=row[-1] > 0) for row in query.all()]

    def read_event(self, event_id):
        return self._query.filter(event_table.c.event_id == event_id).first()

    def create_event(self, name, description, start, end):
        event = Event(
            event_id=self._next_serial_id(), name=name, description=description, start=start, end=end
        )
        self._session.add(event)
        return event


class PgUserRepository(UserRepository, PgRepository):
    model = User
    id_column = user_table.c.user_id

    def find_user_by_email(self, email):
        return self._query.filter(user_table.c.email == email).first()

    def create_user(self, email):
        user = User(user_id=self._next_serial_id(), email=email)
        self._session.add(user)
        return user


class DbService:
    def __init__(self, engine):
        self._engine = engine

    def create_database(self):
        metadata.create_all(self._engine)


class PgInfrastructureRegistry:
    def __init__(self, user, password, database, host, port):
        self._user = user
        self._password = password
        self._host = host
        self._port = port
        self._database = database
        pass

    @cached_property
    def _sa_engine(self):
        return sa.create_engine(
            'postgresql://{user}:{password}@{host}:{port}/{database}'.format(
                user=self._user,
                password=self._password,
                host=self._host,
                port=self._port,
                database=self._database
            )
        )


    @cached_property
    def _sa_session(self):
        Session = sa.orm.sessionmaker(bind=self._sa_engine)
        return scoped_session(Session)

    @cached_property
    def user_repository(self):
        return PgUserRepository(
            session=self._sa_session
        )

    @cached_property
    def event_repository(self):
        return PgEventRepository(
            session=self._sa_session
        )

    @cached_property
    def db_service(self):
        return DbService(self._sa_engine)

    def transactional(self, instance):
        return utils.transactional(instance, lambda: self._sa_session)