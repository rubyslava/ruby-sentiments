class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def eventer
    @eventer ||= Eventer.new(current_user, self)
  end

  def event_base
    @event_base ||= EventBase.new
  end
end
