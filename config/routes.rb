Rails.application.routes.draw do
  root to: 'home#index'
  resources :users, only: [:new, :show, :create]

  get 'about', to: 'about#index'
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'confirmation', to: 'confirmation#new'

  get 'user_dashboard', to: 'dashboard#index'

end
