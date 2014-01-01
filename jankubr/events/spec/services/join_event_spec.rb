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
end
