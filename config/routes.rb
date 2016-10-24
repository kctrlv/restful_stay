Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:new, :create]
  resources :listings, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :cities, param: :city_name, only: [:show]
  resources :trips, only: [:index, :new, :create]

  resources :userroles, only: [:create]

  get 'signup', to: 'users#new'

  get 'about', to: 'about#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  get 'confirmation', to: 'confirmation#new'
  post 'confirmation', to: 'confirmation#create'

  get 'dashboard', to: 'dashboard#index'
  patch 'dashboard/:user_id', to: 'users#update'
  get 'dashboard/:user_id/edit', to: 'dashboard#edit', as: 'dashboard_edit'
  get 'profile/:user_id', to: 'users#show', as: 'profile_show'
end
