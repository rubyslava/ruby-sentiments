class LeaveEventDate
  attr_accessor :event_date

  def initialize(event_date)
    self.event_date = event_date
  end

  def leave(user)
    event_date.users -= [user]
    event_date.save
  end
end
