class EventStorage
  def initialize(e, u)
    @e = e
    @u = u
  end

  def all_events
    @e.all.map { |event| build_event(event) }
  end

  def find_event(id)
    build_event(@e.find(id))
  end

  def save_event(event)
    @e.transaction do
      ar_event = @e.find(event.id)
      ar_event.attributes = event.attributes
      event.attendees.each do |attendee|
        unless ar_event.attendances.include?(attendee.id)
          ar_event.attendances.build(user: @u.find(attendee.id), event: ar_event)
        end
      end
      ar_event.save!
    end
  end

  private

  def build_event(ar_event)
    attendees = ar_event.attendees.map { |attendee| Attendee.new(attendee.attributes) }
    Event.new(ar_event.attributes, attendees)
  end
end
