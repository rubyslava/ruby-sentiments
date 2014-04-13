class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def self.find_by_user_and_events(user, event_ids)
    self.where(user_id: user.id, event_id: event_ids)
  end
end
