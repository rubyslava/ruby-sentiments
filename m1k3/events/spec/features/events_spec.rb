require 'spec_helper'

feature 'Events' do
  scenario 'User can see list of events (name, description, date, from time, to time).' do
    events = create_list(:event, 42)

    sign_in_as('bob@example.com', 'password')

    page.should have_content('Events list')
    within(:xpath, '//table//tr[2]') do
      page.should have_content(events.first.name)
      page.should have_content(events.first.start_at.day)
      page.should have_content(events.first.start_at.hour)
      page.should have_content(events.first.end_at.day)
      page.should have_content(events.first.end_at.hour)
      page.should have_content(events.first.description)
    end
  end

  scenario 'User can sign to attend any of those events.' do
    create(:event)

    sign_in_as('bob@example.com', 'password')

    click_link 'attend'
    page.should have_content 'attending'
  end

  scenario 'User can visit this page later and still see his attendance.' do
    create(:event)
    sign_in_as('bob@example.com', 'password')

    click_link 'attend'

    sign_out
    sign_in_as('bob@example.com', 'password')
    page.should have_content 'attending'
  end
end
