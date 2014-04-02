class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_attendees, dependent: :destroy
  has_many :users, through: :event_attendees

  validates_presence_of :name
  validates_presence_of :date, :starts_at, if: ->(e) {e.day_of_week.blank?}
  validates_presence_of :day_of_week, if: ->(e) {e.date.blank?}

  def user_attending?(user)
    user_ids.include?(user.id)
  end

  def can_join_event?
    capacity_reached? || too_late_to_join?
  end

  def capacity_reached?
    capacity && user_ids.size >= capacity
  end

  def too_late_to_join?
    now = Time.now
    start_timestamp < now || start_timestamp - now < 1.day
  end

  def start_timestamp
    return Time.now unless date
    Time.new(date.year, date.month, date.day, starts_at.hour, starts_at.min)
  end
end
