class EventsController < ApplicationController
  def index
    @events = Event.includes(:attending_users).all
  end

  def attend
    @event = Event.find(params[:id])
    current_user.attend(@event)
    current_user.save!

    redirect_to root_path
  end
end
