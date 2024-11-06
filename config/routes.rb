Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get '/admin', to: 'posts#admin'
  get '/cart', to: 'cart#show'
  delete 'logout', to: 'posts#logout_admin', as: :logout

  post 'cart/add_item', to: 'cart#add_item', as: 'add_item_cart'
  post 'cart/clear', to: 'cart#clear_cart', as: 'clear_cart'

  delete 'remove_item_cart/:id', to: 'cart#remove_item', as: 'remove_item_cart'

  root "posts#index", as: 'home'
  
  get "about" => "pages#about", as: 'about'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
