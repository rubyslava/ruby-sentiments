class Events::AttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    event.attendees << current_user unless event.attending?(current_user)
    redirect_to events_path
  end
end
