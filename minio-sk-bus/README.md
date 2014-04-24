# 'Tell, do not wait to be asked' approach based on EventBus

This approach is rather classical, it uses Postgres as backend, three linked models (Event, User and
Attendance). RSpec with Capybara and FactoryGirl are used for tests.

What is a bit special here is use of [EventBus](https://github.com/kevinrutherford/event_bus) gem. It does not bring much
of an added value for this first specification (round 1), but we hope it will prove itself useful in the future. Currently
it is used only when adding an attendee to an event in events controller.

Instead of checking whether an addition was successful or not, controller hooks two blocks to events
emitted by Event#add_attendee. Those blocks are setting a correct flash message and redirect to root.