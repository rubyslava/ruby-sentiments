# Ruby sentiments - events

## Specification 1:
* User can see list of events (name, description, date, from time, to time).
* User can sign to attend any of those events. 
* User can visit this page later and still see his attendance.

## Solution

Standard Ruby on Rails app with three models

users <---> attendances <---> events

the feature was built using TDD. The tools are rspec+capybara. To style the
frontend I've decided to use Zurb foundation for styling and HAML for
templating. The app is using postgresql as the database. Devise was used
for user authentication.

### Setting up

Assuming you have ruby 2.1.1 and postgresql installed, you set the app
up by:

* rake setup
* edit config/database.yml to suit your environment
* rake db:setup db:seed
