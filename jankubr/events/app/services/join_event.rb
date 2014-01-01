class JoinEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def join(user)
    return false if event.capacity_reached?

    event.users << user
    event.save
  end
end
