Rails.application.routes.draw do
  devise_for :users, class_name: "Ar::User"

  resources :events do
    post :attend, on: :member
  end

  root to: 'events#index'
end
