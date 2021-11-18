Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "my_bookings", to: "pages#my_bookings"
  get "my_bookings/:id", to: "pages#my_booking", as: :my_booking
  get "my_dashboard", to: "pages#my_dashboard", as: :my_dashboard
  delete "my_bookings/:id", to: "bookings#destroy"
  resources :pets, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
