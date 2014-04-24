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

  def register_attendee(attendee)
    Event.new(attributes, @attendees + [attendee])
  end

  def attended_by?(attendee)
    @attendees.include?(attendee)
  end
end
