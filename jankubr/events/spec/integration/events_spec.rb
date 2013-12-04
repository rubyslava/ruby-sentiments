require 'spec_helper'

describe 'Events' do
  it "allows a user to create, update and delete an event" do
    user = FactoryGirl.create(:user)
    login_as(user)
    click_link('Add a new event')
    click_button('Save')
    #validation works
    page.should have_content('Object could not be saved')
    page.should have_content("Name can't be blank")

    fill_in 'Name', with: 'Ruby meetup'
    fill_in 'Date', with: 1.day.from_now.to_date
    fill_in 'Starts at', with: '18:00'
    fill_in 'Ends at', with: '20:00'
    fill_in 'Description', with: 'Meetup of Rubyists'
    click_button('Save')
    #event was created
    event = Event.last
    event.name.should == 'Ruby meetup'
    event.date.should == 1.day.from_now.to_date
    event.starts_at.hour.should == 18
    event.ends_at.hour.should == 20
    event.description.should == 'Meetup of Rubyists'
    page.should have_content(event.name)

    click_link('Update event')
    fill_in 'Name', with: 'Python meetup'
    click_button('Save')
    event.reload.name.should == 'Python meetup'
    page.should have_content(event.name)

    user2 = FactoryGirl.create(:user)
    login_as(user2)
    #another user sees the event
    page.should have_content(event.name)
    #but cannot updated it
    page.should_not have_content('Update event')
    visit "/events/#{event.id}/edit"
    page.should_not have_content('Name')
    page.should have_content("The page you were looking for doesn't exist")
    visit events_path

    login_as(user)
    click_link('Delete event')
    Event.count.should == 0
  end
end
