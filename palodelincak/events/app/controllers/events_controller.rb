class EventsController < ApplicationController
  respond_to :js, :html

  def index
    respond_with(@events = Event.all)
  end

end