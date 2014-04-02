Maglev::PERSISTENT_ROOT[:event] = []
Maglev::PERSISTENT_ROOT[:rsvp] = []


class Event < Struct.new(:id, :date, :place, :limit, :recurrence, :parent)
  def initialize(*params)
    super
    if self.recurrence
      1000.times do |i|
        push = 7 * (i+1) * 60 * 60 * 24
        Event.storage << Event.new(self.class.next_id, self.date + push, self.place, self.limit, false, self)
      end
    end
    Maglev.commit_transaction
  end

  def self.all
    storage
  end

  def late?
    (self.date.to_i - Time.now.to_i) <= 60 * 60 * 24
  end

  def emails
    self.rsvps.collect(&:email)
  end

  def full?
    rsvps.count >= self.limit
  end

  def self.find(id)
    find_all(id).first
  end

  def self.find_all(id)
    storage.select {|event| event.id == id}
  end

  def attending?
    "?"
  end

  def rsvps
    Rsvp.find_all_by_event(id)
  end

  def self.storage
    Maglev::PERSISTENT_ROOT[:event]
  end

  def self.next_id
    if storage.last
      storage.last.id + 1
    else
      0
    end
  end
end

class Rsvp < Struct.new(:id, :event_id, :session_id, :email)
  def destroy
    self.class.storage.delete(self)
  end

  def self.all
    storage
  end

  def self.find(id)
    storage.select {|event| event.id == id}.first
  end

  def self.storage
    Maglev::PERSISTENT_ROOT[:rsvp]
  end

  def self.next_id
    if storage.last
      storage.last.id + 1
    else
      0
    end
  end

  def self.attending?(id, session_id)
    rsvps = Rsvp.find_all_by_event(id.to_i)
    rsvps.select {|r| r.session_id == session_id}.any?
  end

  def self.find_all_by_event(id)
    storage.select {|rsvp| rsvp.event_id == id}
  end
end
