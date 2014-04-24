require 'spec_helper'

feature 'Event attendance management' do
  before { seed_eventer_application_with_events }

  scenario 'User lists all events' do
    user_opens_eventer_application
    application_shows_a_list_of_events
  end

  scenario 'User marks an event as attending' do
    user_opens_eventer_application
    user_registers_a_new_account('jsuchal@test.com')
    user_signs_into_event('Rubyslava #38')
    application_shows_user_is_attending('Rubyslava #38')
  end

  scenario 'User sees events he is attending' do
    user_opens_eventer_application
    user_registers_a_new_account('jsuchal@test.com')
    user_signs_into_event('Rubyslava #38')
    user_restarts_eventer_application
    user_signs_in_as('jsuchal@test.com')
    application_shows_user_is_attending('Rubyslava #38')
  end
end
