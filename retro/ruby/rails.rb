require 'rails'
require 'action_controller/railtie'
require './db'

class Dating < Rails::Application
  # Set Rails.root to the same folder as this file
  config.root = File.dirname(__FILE__)

  config.secret_key_base = '****************************************'
  config.secret_token = '****************************************'
  config.serve_static_assets = true

  config.logger = Logger.new(STDOUT) # sry win :'(
  Rails.logger = config.logger

  routes.draw do
    get '/(admin)' => 'meetups#index'
    post '/rsvp/:id' => 'attendings#create'
    post '/rsvp/:id/delete' => 'attendings#destroy'
  end
end

class MeetupsController < ActionController::Base
  prepend_view_path "#{Rails.root}"
  def index
    if request.fullpath == '/admin'
      if authenticate_with_http_basic {|u, p| u == "admin" && p == "pass"}
        @admin = true
      else
        request_http_basic_authentication and return
      end
    end

    @events = Event.all.sort_by!(&:date)
    render '/views/index'
  end
end

class AttendingsController < ActionController::Base
  def create
    Rsvp.storage << Rsvp.new(Rsvp.next_id, params[:id].to_i, request.session_options[:id], params[:email])
    redirect_to '/'
  end

  def destroy
    event = Event.find(params["id"].to_i)
    if event
      if rsvp = event.rsvps.select{|r| r.session_id == request.session["session_id"]}.first
        rsvp.destroy
        redirect_to '/'
      else
        head 401
      end
    else
      head 404
    end
  end
end

Event.storage << Event.new(0, Time.now, 'Fraktal', 1, false)
Event.storage << Event.new(1, Time.now + 100000, 'Fraktal', 2, true)
Event.storage << Event.new(2, Time.now + 1000000, 'Fraktal', 0, true)
Event.storage << Event.new(3, Time.now - 1000000, 'Fraktal', 0, false)
