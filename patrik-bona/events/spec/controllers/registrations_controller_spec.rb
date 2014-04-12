require 'spec_helper'

describe RegistrationsController do
  describe '#create' do
    it 'updates events cookies with current event' do
      post :create, event_id: 1

      expect(cookies['event_1']).to be_true
    end

    it 'redirects to root_path' do
      post :create, event_id: 1

      expect(response).to redirect_to(root_path)
    end
  end
end
