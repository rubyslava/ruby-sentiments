require 'spec_helper'

describe EventsController do

  before do
    @event = FactoryGirl.create('event')
    @user = FactoryGirl.create('user')
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'toggle_participation'" do
    it "returns http redirect" do
      post 'toggle_participation', { id: @event.id }
      response.should be_redirect
    end

    it "returns http success on change" do
      sign_in(@user)
      post 'toggle_participation', { id: @event.id }
      response.should redirect_to root_path

      post 'toggle_participation', { id: @event.id, format: 'js' }
      response.should be_success
    end
  end

end
