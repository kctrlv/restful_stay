Rails.application.routes.draw do
  root to: 'home#index'
  get 'about', to: 'about#index'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'


end
