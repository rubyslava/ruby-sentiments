class EventsController < ApplicationController
  before_action :authenticate_user!, only: 'toggle_participation'
  include EventsHelper

  def index
    @events = Event.order('start_time DESC')
    @participants = Participant.find_by_user_and_events(current_user, @events.map{ |e| e.id })
  end

  def toggle_participation
    @event = Event.find(event_params)

    @active = @event.toggle_participation(current_user)
    expire_fragment(cache_key_event_user(@event, current_user))
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

  def event_params
    params.require('id')
  end
end
