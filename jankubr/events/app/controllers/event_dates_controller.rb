class EventDatesController < ApplicationController
  def join
    if JoinEventDate.new(@event_date).join(current_user)
      flash[:notice] = t('events.joined')
    else
      flash[:alert] = t('events.could_not_join')
    end
    redirect_to(events_path)
  end

  def leave
    if LeaveEventDate.new(@event_date).leave(current_user)
      flash[:notice] = t('events.left')
    else
      flash[:alert] = t('events.could_not_leave')
    end
    redirect_to(events_path)
  end

private

  def check_rights
    @event_date = EventDate.find(params[:id]) if params[:id]
    @policy = EventDatesPolicy.new(current_user, params, @event_date)
    @policy.guard!
  end
end
