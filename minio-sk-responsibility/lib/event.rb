class Event
  attr_reader :id, :name, :description, :date, :from, :to, :attendees,
              :attributes

  def initialize(attributes, attendees)
    @attributes = attributes
    @id = attributes["id"]
    @name = attributes["name"]
    @description = attributes["description"]
    @date = attributes["date"]
    @from = attributes["from"]
    @to = attributes["to"]
    @attendees = attendees
  end

  def register_attendee(attendee)
    Event.new(@attributes, @attendees + [attendee])
  end

  def attended_by?(attendee)
    @attendees.include?(attendee)
  end
end
