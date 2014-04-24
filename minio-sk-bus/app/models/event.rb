class Event < ActiveRecord::Base
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user

  def add_attendee(user)
    if user.is_attending?(self)
      EventBus.publish(:already_attending, event: self, user: user)
    else
      Attendance.create!(event: self, user: user)
      EventBus.publish(:added_attendee, event: self, user: user)
    end
  end
end
