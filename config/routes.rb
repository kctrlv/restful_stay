Rails.application.routes.draw do
  root to: 'home#index'
  resources :users, only: [:new, :show, :create]

  get 'about', to: 'about#index'
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'confirmation', to: 'confirmation#new'

  delete 'logout', to: 'sessions#destroy'

  get 'user_dashboard', to: 'dashboard#index'

end
