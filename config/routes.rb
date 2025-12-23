Rails.application.routes.draw do
  get "friendships/create"
  get "friendships/accept"
  get "friendships/decline"
  
  namespace :admin do
    get "dashboard", to: "dashboard#index"
  end

  devise_for :users, controllers: {
  registrations: "users/registrations",
  sessions: "users/sessions"
  }

  get "home_page/index"
  get "home/index"
  get "/login", to: "home_page#login"
  get "/register", to: "home_page#register"
  post "/register", to: "home_page#create_user"

  get "/profile/edit", to: "users#edit_profile", as: :edit_profile
  patch "/profile/update", to: "users#update_profile", as: :update_profile
  get "/profile/password", to: "users#edit_password", as: :edit_password
  patch "/profile/password/update", to: "users#update_password", as: :update_password


  namespace :admin do
    get "dashboard", to: "dashboard#index"
  end

  resources :users, only: [:index]

  resources :friendships, only: [:create] do
    member do
      patch :accept
      delete :decline
    end
  end

  get "/friend_requests", to: "friendships#requests", as: :friend_requests

  get "/friends", to: "friendships#friends", as: :friends

  resources :posts, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :destroy]
  end



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root to: "home_page#index"
end
