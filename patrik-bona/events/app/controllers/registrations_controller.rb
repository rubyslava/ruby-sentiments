class RegistrationsController < ApplicationController
  def create
    cookies.permanent["event_#{event_id}"] = true
    redirect_to root_path
  end

  private

  def event_id
    params[:event_id]
  end
end
