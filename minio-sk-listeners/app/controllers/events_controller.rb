class EventsController < ApplicationController
  # commands
  def index
    eventer.start
  end

  def attend
    event = Event.find(params[:id])

    eventer.attend(event)

    event_base.persist(event)
  end

  # listener
  def application_started
    @events = Event.includes(:attending_users).all

    render :index
  end

  def attendance_added(attendance)
    redirect_to root_path
  end
end
