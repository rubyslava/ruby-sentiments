class EventsController < ApplicationController
  def index
    @events = Event.all.order(:date)
  end

  def show
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        redirect_to events_path , flash: {warning: t('event.event_does_not_exist')}
    end
    @event_manager = EventManager.new(current_user, @event)
  end
end
