require './db'
require 'sinatra/base'

class Dating < Sinatra::Base
  set :root, File.dirname(__FILE__)
  helpers do
    def button_to(text, link)
      %&<form action="#{link}" class="button_to" method="post"><div><input type="submit" value="#{text}"></div></form>&
    end
  end

  get '/' do
    @events = Event.all
    erb :index
  end

  post '/attend/:id/:rsvp' do
    event = Event.find(params[:id].to_i)
    event.rsvp = params[:rsvp] == '1' ? true : false
    redirect '/'
  end
end

DB << Event.new(1, Time.now, 'Fraktal', nil)
DB << Event.new(2, Time.now + 100000, 'Fraktal', nil)
DB << Event.new(3, Time.now + 1000000, 'Fraktal', nil)
