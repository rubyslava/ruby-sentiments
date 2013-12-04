class EventsPolicy < Policy
  def allowed_current_action?()
    if in_action?(:index, :new, :create)
      true
    elsif in_action?(:edit, :update, :destroy)
      record.user == user
    end
  end

  def filtered_params
    params.require(:event).permit(:name, :date, :starts_at, :ends_at, :description)
  end
end
