Events for Ruby sentiments
==========================

INCREMENT 2
--------------

1. User can cancel his registration to event.
Added a service object LeaveEvent that handles this. Controller action only delegates to this object.
2. Event has limit of attendees.
Added capacity field to events table. When capacity reached (as determined by the Event#capacity_reached? method), the "I will attend this event"
button is not shown. 
Also the service object JoinEvent won't let a user join if the capacity is reached (If user tries to go around the missing
button). For this I needed a first unit test.
3. User can be an admin and then see a list of emails of attending users.
As I had a complete user management in place, simple addition of "role" column in users gave me the ability to have an admin user.
One bigger change was needed here, the serialized "attending_user_ids" column from events table had to be replaced with a join table.
Otherwise, to show the attendees' emails, I'd need to query them with a separate call for each event or do some custom ugly pre-fetching.
Using a join table I can use standard Rails' "includes": Event.includes(:users).order('date, starts_at').


INCREMENT 1
--------------
I approached this as a normal on-the-job task, meaning I used the tools I'm most familiar with and I know
I can rely on during daily development and will not let me down when I need to develop features fast.

That said, I used this opportunity to showcase some concepts that worked for me while working on a bigger Rails
app (30k lines not counting tests) that may be a bit premature here.

Policy objects
--------------
Access rights are controlled by policy objects, one for each controller. EventsPolicy is a child of Policy
that has the basic setup. In EventsPolicy you only whitelist actions that the current user can acess. This
can also depend on the record that they currently work on. Policies are also used in views to show/hide
action links, e.g. allowed?(:destroy, event).
Policies can also scope collections based on what the current user can see.

Service objects
---------------
Lately I prefer to keep my models as light as possible. They should contain method that directly relate
to their data and mostly only to reading them. In Event I have user_attending?(user), which is only a convenience
method over the model's data.
When the user wants to join an event though, I don't put that code in the model, but create a service object instead.
Service objects are a layer between my controllers and models. They do more complicated data crunching and are
responsible for saving the model in the database.

View inheritance
----------------
application/new.html.erb defines a common new.html.erb template that does not need to be repeated for each controller.

Integration tests
-----------------
I prefer capybara integration (feature) tests over any other type of tests.

SCSS variables
----------------
I take advantage of SCSS variables by defining all colors in colors.css.scss as variables and
using only the variables in other CSS files.

