Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Show a food item
  resources :items

  get "my-items", to: "items#my_items"
  patch "my-items/set_status", to: "items#set_status", as: :set_item_status

  resources :chatrooms, only: %i[show index] do
    post "messages", to: "messages#create"
  end

  resources :messages, only: %i[new create] do
    get "feedbacks/new", to: "feedbacks#new"
    post "feedbacks", to: "feedbacks#create"
  end

  resources :profiles, only: %i[show edit update]
end
