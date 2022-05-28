Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # CRUD actions / routes for items
  resources :items

  # Shows user's food/ingredient items
  get "my-items", to: "items#my_items"

  # Creates requests (chatrooms) for giver and receiver to send messages
  resources :requests, only: %i[show index create] do
    post "messages", to: "messages#create"
  end

  # Creates feedback for the end of messages between users.
  resources :messages, only: %i[new create] do
    get "feedbacks/new", to: "feedbacks#new"
    post "feedbacks", to: "feedbacks#create"
  end

  resources :profiles, only: %i[show edit update]
end
