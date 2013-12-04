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
    get '/'  => 'meetups#index'
    post '/attend/:id/:rsvp' => 'attendings#create', as: :attend
  end
end

class MeetupsController < ActionController::Base
  prepend_view_path "#{Rails.root}"
  def index
    @events = Event.all
    render '/views/index'
  end
end

class AttendingsController < ActionController::Base
  def create
    event = Event.find(params[:id].to_i)
    event.rsvp = params[:rsvp] == '1' ? true : false
    redirect_to '/'
  end
end

DB << Event.new(1, Time.now, 'Fraktal', nil)
DB << Event.new(2, Time.now + 100000, 'Fraktal', nil)
DB << Event.new(3, Time.now + 1000000, 'Fraktal', nil)
