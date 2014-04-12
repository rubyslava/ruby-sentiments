Rails.application.routes.draw do
  root 'events#index'

  resources :events, only: [] do
    resources :registrations, only: [:create]
  end
end
