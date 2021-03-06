Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  # CRUD actions / routes for items
  resources :items do
    member do
      post 'toggle_favorite', to: "items#toggle_favorite"
    end
  end

  # Shows user's food/ingredient items
  get "my-items", to: "items#my_items", as: :my_items

  # Creates requests for giver and receiver to send messages
  resources :requests, only: %i[show index create] do
    post "messages", to: "messages#create"
  end

  # Creates feedback for the end of messages between users.
  resources :messages, only: %i[new create] do
    get "feedbacks/new", to: "feedbacks#new"
    post "feedbacks", to: "feedbacks#create"
  end

  # resources :profiles, only: %i[show edit update]
  get '/my-profile', to: 'profiles#my_profile', as: :my_profile

  get '/my-favorites', to: 'pages#my_favorites', as: :my_favorites
end
