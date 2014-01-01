class LeaveEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def leave(user)
    event.users -= [user]
    event.save
  end
end
