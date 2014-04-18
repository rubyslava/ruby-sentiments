Events::Application.routes.draw do

  get 'users/participate/:event_id', to: 'users#participate', as: 'event_participate'
  get 'users/cancel/:event_id', to: 'users#cancel', as: 'cancel_participate'
  resources :events, only: [:index, :show]
  devise_for :users
  root 'events#index'
end
