class UsersController < ApplicationController

  before_action :load_objects

  def participate
    if @event_manager.participate
      redirect_to event_path(@event), notice: t('event.i_m_participate')
    else
      redirect_to event_path(@event), notice: t('event.i_m_participate')
    end
  end

  def cancel
    if @event_manager.cancel_participate
      redirect_to event_path(@event), notice: t('event.canceled_participation')
    else
      redirect_to event_path(@event), flash: {warning: t('event.can_not_cancel_participation')}
    end
  end

  private

  def load_objects
    begin
      @event = Event.find(params[:event_id])
      @event_manager = EventManager.new(current_user, @event)
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path , flash: {warning: t('event.event_does_not_exist')}
    end
  end
end
