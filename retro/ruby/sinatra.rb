require './db'
require 'sinatra/base'

class Dating < Sinatra::Base
  set :root, File.dirname(__FILE__)

  configure do
    enable :sessions
  end

  helpers do
    def button_to(text, link)
      %&<form action="#{link}" class="button_to" method="post"><div><input type="submit" value="#{text}"></div></form>&
    end
  end

  ['/', '/admin'].each do |route|
    get route do
      @admin = false
      if request.fullpath == '/admin'
        if authenticate_with_http_basic {|u, p| u == "admin" && p == "pass"}
          @admin = true
        else
          request_http_basic_authentication and return
        end
      end

      @events = Event.all.sort_by(&:date)
      erb :index
    end
  end

  post '/rsvp/:id' do
    Rsvp.storage << Rsvp.new(Rsvp.next_id, params["id"].to_i, request.session["session_id"], params["email"])
    redirect '/'
  end

  post '/rsvp/:id/delete' do
    event = Event.find(params["id"].to_i)
    if event
      if rsvp = event.rsvps.select{|r| r.session_id == request.session["session_id"]}.first
        rsvp.destroy
        redirect '/'
      else
        halt 401
      end
    else
      halt 404
    end
  end
end

Event.storage << Event.new(0, Time.now, 'Fraktal', 1, false)
Event.storage << Event.new(1, Time.now + 100000, 'Fraktal', 2, false)
Event.storage << Event.new(2, Time.now + 1000000, 'Fraktal', 0, true)
Event.storage << Event.new(3, Time.now - 1000000, 'Fraktal', 0, false)
