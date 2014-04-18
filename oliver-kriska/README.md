# Events
=========

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

## My Solution

Normal RoR 4.1 (Ruby 2.1.1) app with 3 models (User, Event, Participant) [Diagram](http://cl.ly/image/1F1S2r2L3i1i)

I use custom class EventManager (app/services) for event management (add participation, cancel participation, ...).

Sorry, but I don't write any RoR tests. User rake db:seed for load sample data.


## Rails Apps Composer Recipes 

* apps4
* controllers
* core
* deployment
* email
* extras
* frontend
* gems
* git
* init
* models
* prelaunch
* railsapps
* readme
* routes
* saas
* setup
* testing
* views

### Preferences:

* git: true
* apps4: none
* dev_webserver: thin
* prod_webserver: unicorn
* database: sqlite
* templates: erb
* unit_test: test_unit
* integration: none
* continuous_testing: none
* fixtures: none
* frontend: bootstrap3
* email: none
* authentication: devise
* devise_modules: default
* authorization: pundit
* form_builder: simple_form
* starter_app: home_app
* rvmrc: false
* quiet_assets: true
* local_env_file: figaro
* better_errors: true
* pry: true
* ban_spiders: true

### Development

-   Template Engine: ERB
-   Testing Framework: Test::Unit
-   Front-end Framework: Bootstrap 3.0 (Sass)
-   Form Builder: SimpleForm
-   Authentication: Devise
-   Authorization: None
-   Admin: None
