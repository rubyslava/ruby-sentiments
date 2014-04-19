--------------------
Installation:
--------------------
You need at least python 3.3

python setup.py install

--------------------
Create database:
--------------------
rsmt create_db -U user -W password -H localhost -p 5432 -d rsmt

Target database is postgresql

--------------------
Run debug server:
--------------------
rsmt runserver -U user -W password -H localhost -p 5432 -d rsmt

--------------------
Design decisions:
--------------------

I've chosen hexadecimal architecture as it provides good encapsulation and
hiding of implementation details.

Model
For specification 1 there are event and user objects. Event contains user participations
(many to many relation).

App interface
Application has the following use cases:
- EventService.create_event(name, description, start, end)
- EventService.list_events(current_user_email)
- AttendanceService.attend_event_by_user(event_id, user_email)

Application is structured by hexadecimal architecture with following layers:
- application
- domain
- ports
    - db
    - web
    - command line

Application
--------------------

Application object contains all the services exposed by application. Currently
EventService and AttendanceService. These services access domain objects and
services. They call actions on these objects.
Application services creates interface of the application. Each service call
creates transaction boundary and therefore is atomic.

Domain
--------------------

Domain layer contains all the business logic. Business logic is spread among the
domain objects and domain services.

Ports
--------------------

According to hexadecimal architecture there are internal and external
components. Internal components are all components in Application and Domain
layer. These components are accessed from the external components.
External components are either inbound or outbound.

Inbound component calls only the internal services from application layer.
For instance web service, command line program.

Outbound component is called only from the internal service (either application
or domain).
For instance db repository or email sender.