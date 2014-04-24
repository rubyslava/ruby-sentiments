class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def event_storage
    @event_storage ||= EventStorage.new(Ar::Event, Ar::User)
  end

  def meetup_service
    @meetup_service ||= MeetupService.new
  end
end
