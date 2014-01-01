DB = []

class Event < Struct.new(:id, :date, :place, :rsvp)
  def self.all
    DB
  end

  def self.find(id)
    DB.select {|event| event.id == id}.first
  end

  def attending?
    return "true" if self.rsvp === true
    return "false" if self.rsvp === false
    return "nothing" if self.rsvp === nil
  end
end
