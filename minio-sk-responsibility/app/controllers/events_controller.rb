class EventsController < ApplicationController
  def index
    @events = event_storage.all_events
  end

  def attend
    event = meetup_service.register_attendee(current_event, current_attendee)
    event_storage.save_event(event)
    redirect_to action: :index
  end

  private

  def current_event
    event_storage.find_event(params[:id])
  end

  def current_attendee
    if current_user
      Attendee.new(current_user.attributes)
    else
      Attendee.new({})
    end
  end

  helper_method :current_attendee
end
