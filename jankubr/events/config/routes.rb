Events::Application.routes.draw do
  devise_for :users
  resources :events do
    member {
      patch :join
      patch :leave
    }
  end

  root to: 'events#index'
end
