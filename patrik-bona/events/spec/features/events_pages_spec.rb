require 'spec_helper'

feature 'Events pages' do
  scenario 'user see events' do
    Timecop.freeze(Time.now) do
      create(:event, name: 'Rubyslava', date: Date.today, from_time: '18:00', to_time: '20:00')
      visit root_path

      expect(page).to have_content 'Rubyslava'
      expect(page).to have_content Date.today
      expect(page).to have_content '18:00'
      expect(page).to have_content '20:00'
    end
  end

  scenario 'user joins event and see it later' do
    create(:event)
    visit root_path
    click_button 'Join'

    expect_to_be_registered_for_event
    visit root_path
    expect_to_be_registered_for_event
  end

  private

  def expect_to_be_registered_for_event
    expect(page).to have_css '.event.going'
    expect(page).to have_content 'You are registered for this event!'
  end

end
