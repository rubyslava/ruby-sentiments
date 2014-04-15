require 'spec_helper'

feature 'Events' do
  scenario 'User can see list of events (name, description, date, from time, to time).' do
    events = create_list(:event, 42)

    visit root_path

    page.should have_css('.event', count: 42)
    page.should have_content(events.first.name)
  end
  scenario 'User can sign to attend any of those events.'
  scenario 'User can visit this page later and still see his attendance.'
end
