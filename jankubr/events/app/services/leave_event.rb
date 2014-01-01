class LeaveEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def leave(user)
    event.attending_user_ids -= [user.id]
    event.save
  end
end
