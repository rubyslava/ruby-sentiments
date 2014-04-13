Rails.application.routes.draw do
  root 'events#index'

  devise_for :users
  resources :events do
    post :attend, on: :member
  end
end
