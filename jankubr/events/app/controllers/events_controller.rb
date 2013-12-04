class EventsController < ApplicationController
  def index
    @events = @policy.scope(Event.order('date, starts_at'))
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(@policy.filtered_params.merge(user_id: current_user.id))
    if @event.save
      flash[:notice] = t('events.saved')
      redirect_to(events_path)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(@policy.filtered_params)
      flash[:notice] = t('events.updated')
      redirect_to(events_path)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    flash[:notice] = t('events.deleted')
    redirect_to(events_path)
  end

private

  def check_rights
    @event = Event.find(params[:id]) if params[:id]
    @policy = EventsPolicy.new(current_user, params, @event)
    @policy.guard!
  end
end
