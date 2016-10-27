Rails.application.routes.draw do
  root to: 'home#index'

  resources :users, only: [:new, :create]
  resources :listings, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :cities, param: :city_name, only: [:show]
  resources :trips, only: [:index, :new, :create] do
    resource :review, only: [:show, :new, :edit]
  end
  resources :userroles, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index] do
        resource :review, only: [:create, :show, :destroy, :update]
      end
    end
  end

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

  get 'reservations', to: 'reservations#index', as: "reservations"

namespace :api do
  namespace :v1 do
    get 'availabledates/:id', to: 'availabledates#index', as: 'availabledates'
  end
end


  namespace :admin do
    get 'dashboard', to: "dashboard#index", as: "dashboard"
    get 'dashboard/manage_users', to: "users#index", as: "manage_users"
    get 'dashboard/manage_users/:user_id/edit', to: "users#edit", as: "edit_user"
    patch 'dashboard/manage_users/:user_id', to: "users#update", as: "user_update"
    get 'dashboard/manage_listings', to: "listings#index", as: "manage_listings"
    get 'dashboard/manage_listings/:listing_id', to: "listings#show", as: "show_listing"
    delete 'dashboard/manage_listings/:listing_id', to: "listings#destroy", as: "listing_delete"
    get 'dashboard/manage_cities', to: "cities#index", as: "manage_cities"
    get 'dashboard/manage_cities/new', to: "cities#new", as: "new_city"
    get 'dashboard/manage_cities/:city_id', to: "cities#show", as: "show_city"
    delete 'dashboard/manage_cities/:city_id', to: "cities#destroy", as: "city_delete"
    post 'dashboard/manage_cities', to: "cities#create", as: "create_city"
  end
end
