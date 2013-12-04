Events for Ruby sentiments
==========================
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

