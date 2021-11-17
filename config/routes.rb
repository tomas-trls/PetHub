Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "my_bookings", to: "pages#my_bookings"
  get "my_bookings/:id", to: "pages#my_booking", as: :my_booking
  delete "my_bookings/:id", to: "bookings#destroy"
  resources :pets, only: [:new, :create, :index, :show, :edit, :update] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
