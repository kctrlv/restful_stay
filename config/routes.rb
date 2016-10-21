Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:new, :create]
  resources :listings, only: [:index, :new, :create]

  resources :userroles, only: [:create]

  get 'signup', to: 'users#new'

  get 'about', to: 'about#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  get 'confirmation', to: 'confirmation#new'
  post 'confirmation', to: 'confirmation#create'

  get 'dashboard', to: 'dashboard#index'
  
  get 'profile/:user_id', to: 'profiles#show', as: 'profile_show'
  get 'profile/:user_id/edit', to: 'profiles#edit', as: 'profile_edit'
  patch 'profile/:user_id', to: 'users#update'
end
