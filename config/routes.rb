Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # CRUD actions / routes for items
  resources :items

  # Shows user's food/ingredient items
  get "my-items", to: "items#my_items"

  # Edits status of food/ingredient item
  patch "my-items/set_status", to: "items#set_status", as: :set_item_status

  # Creates chatroom for giver and receiver to send messages
  resources :chatrooms, only: %i[show index] do
    post "messages", to: "messages#create"
  end

  # Creates feedback for the end of messages between users.
  resources :messages, only: %i[new create] do
    get "feedbacks/new", to: "feedbacks#new"
    post "feedbacks", to: "feedbacks#create"
  end

  resources :profiles, only: %i[show edit update]
end
