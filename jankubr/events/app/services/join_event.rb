class JoinEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def join(user)
    return false if event.can_join_event?

    event.users << user
    event.save
  end
end
