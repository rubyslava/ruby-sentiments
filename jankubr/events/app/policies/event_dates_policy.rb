class EventDatesPolicy < Policy
  def allowed_current_action?
    if in_action?(:join)
      true
    elsif in_action?(:leave)
      record.user_attending?(user)
    end
  end
end
