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
    event.capacity.should == nil
    page.should have_content(event.name)

    click_link('Update event')
    fill_in 'Name', with: 'Python meetup'
    fill_in 'Capacity', with: 20
    click_button('Save')
    event.reload.name.should == 'Python meetup'
    event.capacity.should == 20
    page.should have_content(event.name)

    user2 = FactoryGirl.create(:user)
    login_as(user2)
    #another user sees the event
    page.should have_content(event.name)
    #but cannot updated it
    page.should_not have_content('Update event')
    visit "/events/#{event.id}/edit"
    page.should_not have_content('Name')
    page.should have_content("The page cannot be accessed")
    visit events_path

    login_as(user)
    click_link('Delete event')
    Event.count.should == 0
  end

  it "allows user to join and leave an event" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, capacity: 20)
    login_as(user)
    click_button('I will attend this event')

    event.reload.user_attending?(user).should == true
    page.should have_content('You are attending this event')
    page.should have_content('1 of 20')

    click_button('Leave')
    page.should_not have_content('You are attending this event')
    event.reload.user_attending?(user).should == false
  end

  it "allows admin to see emails of all attendees" do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user)
    admin.update_attributes(role: 'admin')
    event = FactoryGirl.create(:event)
    JoinEvent.new(event).join(user)

    login_as(admin)
    page.should have_content(user.email)
    page.should_not have_content(event.user.email)

    login_as(user)
    page.should_not have_content(user.email)
    page.should_not have_content(event.user.email)
  end
end
