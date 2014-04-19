class EventManager

  def initialize(user, event)
    @event = event
    @user = user
  end

  def can_participate?(user = @user)
    if user.nil?
      false
    else
      !@event.users.include? user
    end
  end

  def participate?(user = @user)
    @event.users.include? user
  end

  def participate(user = @user)
    if can_participate?
      @event.users << user
      true
    else
      false
    end
  end

  def can_cancel_participate?(user = @user)
    !user.nil?
  end

  def cancel_participate(user = @user)
    if can_cancel_participate?
      @event.users.delete(user)
      true
    else
      false
    end
  end

end