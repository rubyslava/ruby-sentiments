class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_attendees, dependent: :destroy
  has_many :users, through: :event_attendees

  validates_presence_of :name, :date, :starts_at

  def user_attending?(user)
    user_ids.include?(user.id)
  end

  def capacity_reached?
    capacity && user_ids.size >= capacity
  end
end
