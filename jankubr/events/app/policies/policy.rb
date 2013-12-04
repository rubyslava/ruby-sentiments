class Policy
  attr_accessor :user, :params, :action, :record, :request

  def initialize(user, params, record = nil, request = nil)
    self.user = user
    self.params = params
    self.action = params[:action]
    self.record = record
    self.request = request
  end

  def allowed_current_action?
    false
  end

  def allowed?(another_action)
    action_was = action
    self.action = another_action.to_s
    can = allowed_current_action?
    self.action = action_was
    can
  end

  def guard!
    raise PermissionDenied unless allowed_current_action?
  end

  def scope(collection)
    collection
  end

private

  def in_action?(*actions)
    actions.flatten.map(&:to_s).include?(action)
  end
end
