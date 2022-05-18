Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Show a food item
  resources :items, only: :show

  resources :chatrooms, only: :show do
    get 'messages', to: 'messages#create'
  end

  resources :profiles, only: %i[show edit]
end

  # resources :bookings do
  #   resources :pokemon_reviews, only: [ :new, :create ]
  # end

  # resources :bookings, only: [:index, :edit, :update]
