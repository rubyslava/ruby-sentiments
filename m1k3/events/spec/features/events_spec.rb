require 'spec_helper'

feature 'Events' do
  scenario 'User can see list of events (name, description, date, from time, to time).' do
    events = create_list(:event, 42)

    visit root_path

    page.should have_content('Events list')
    page.should have_content(events.first.name)
    page.should have_content(events.last.name)
  end
  scenario 'User can sign to attend any of those events.'
  scenario 'User can visit this page later and still see his attendance.'
end
