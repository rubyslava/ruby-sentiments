class EventDate < ActiveRecord::Base
  belongs_to :event
  has_many :event_attendees, dependent: :destroy
  has_many :users, through: :event_attendees

  scope :future, ->(now = Time.now) {joins(:event)
                                     .where('event_dates.date > ? OR (event_dates.date = ? AND strftime("%H", events.starts_at) > ?)',
                                             now.to_date, now.to_date, now.hour)}

  def user_attending?(user)
    user_ids.include?(user.id)
  end

  def can_join?
    capacity_reached? || too_late_to_join?
  end

  def capacity_reached?
    event.capacity && user_ids.size >= event.capacity
  end

  def too_late_to_join?
    now = Time.now
    start_timestamp < now || start_timestamp - now < 1.day
  end

  def start_timestamp
    Time.new(date.year, date.month, date.day, event.starts_at.hour, event.starts_at.min)
  end

end
