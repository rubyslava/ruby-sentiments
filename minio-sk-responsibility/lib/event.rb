class Event
  include Virtus.model

  attribute :id, Integer
  attribute :name, String
  attribute :description, String
  attribute :date, Date
  attribute :from, Time
  attribute :to, Time

  attr_reader :attendees

  def initialize(attributes, attendees)
    super(attributes)
    @attendees = attendees
  end

  def register_attendee(attendee, listener)
    if can_be_attended_by?(attendee)
      listener.attendance_added(Event.new(attributes, @attendees + [attendee]))
    else
      listener.attendance_not_allowed(self)
    end
  end

  def attended_by?(attendee)
    @attendees.include?(attendee)
  end

  def can_be_attended_by?(attendee)
    !attended_by?(attendee)
  end
end
