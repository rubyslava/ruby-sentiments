require 'spec_helper'

describe EventsController do
  describe '#index' do
    it 'assings events' do
      event = create(:event)

      get :index

      expect(assigns[:events]).to eq [event]
    end

    it 'renders index template' do
      get :index

      expect(response).to render_template(:index)
    end
  end
end
