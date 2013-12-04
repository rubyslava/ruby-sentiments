class JoinEvent
  attr_accessor :event

  def initialize(event)
    self.event = event
  end

  def join(user)
    event.attending_user_ids = (event.attending_user_ids + [user.id]).uniq
    event.save
  end
end
