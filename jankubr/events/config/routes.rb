Events::Application.routes.draw do
  devise_for :users
  resources :events do
    member {
      patch :join
    }
  end

  root to: 'events#index'
end
