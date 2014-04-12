class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  private

  def going_to?(event)
    cookies["event_#{event.id}"]
  end
  helper_method :going_to?
end
