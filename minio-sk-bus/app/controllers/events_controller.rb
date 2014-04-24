class EventsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_events = current_user.events
    @all_events = Event.where.not(id: Event.joins(:attendances).where(attendances: {user_id: current_user.id}).select(:id)) #TODO move to scope?
  end

  def add_attendee
    EventBus.subscribe(:added_attendee) do |params|
      flash[:notice] = "#{params[:event].name} joined succesfully."
      redirect_to root_path
    end

    EventBus.subscribe(:already_attending) do |params|
      flash[:notice] = "you are already attending #{params[:event].name}."
      redirect_to root_path
    end

    event = Event.find_by_id(params[:id])
    event.add_attendee(current_user)
  end
end
