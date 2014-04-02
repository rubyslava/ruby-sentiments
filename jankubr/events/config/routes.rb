Events::Application.routes.draw do
  devise_for :users
  resources :events
  resources :event_dates do
    member {
      patch :join
      patch :leave
    }
  end

  root to: 'events#index'
end
