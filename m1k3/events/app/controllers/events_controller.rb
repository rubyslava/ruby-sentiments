class EventsController < ApplicationController
  def index
    @events = Event.includes(:attendees)
  end
end
