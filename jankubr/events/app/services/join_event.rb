class JoinEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def join(user)
    return false if event.capacity_reached?

    event.attending_user_ids = (event.attending_user_ids + [user.id]).uniq
    event.save
  end
end
