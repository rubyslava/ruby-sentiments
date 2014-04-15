Rails.application.routes.draw do
  devise_for :users

  resources :events, only: 'index' do
    member do
      post 'toggle_participation' => 'events#toggle_participation', as: 'join_user_to'
    end
  end
  root 'events#index'
end
