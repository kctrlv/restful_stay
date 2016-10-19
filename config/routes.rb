Rails.application.routes.draw do
  root to: 'home#index'
  get 'about', to: 'about#index'
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'user_dashboard', to: 'dashboard#index'
end
