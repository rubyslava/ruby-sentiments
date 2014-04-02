require 'spec_helper'

describe JoinEvent do
  it "doesn't let user join event that reached its capacity" do
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, capacity: 1)

    join_event = JoinEvent.new(event)
    join_event.join(user).should == true
    join_event.join(user2).should == false
  end

  it "doesn't let user join event that starts sooner than 1 day from now" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.create(:event, date: Date.today)

    join_event = JoinEvent.new(event)
    join_event.join(user).should == false

    event.update_attributes(date: Date.tomorrow)
    join_event.join(user).should == true
  end
end
