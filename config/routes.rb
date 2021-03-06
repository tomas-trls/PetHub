Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "my_bookings", to: "pages#my_bookings"
  get "my_bookings/:id", to: "pages#my_booking", as: :my_booking
  get "my_dashboard", to: "pages#my_dashboard"
  delete "my_bookings/:id", to: "bookings#destroy"
  patch "confirm_booking/:id", to: "bookings#confirm_booking", as: :confirm_booking
  patch "owner_confirm/:id", to: "bookings#owner_confirm", as: :owner_confirm
  patch "sitter_confirm/:id", to: "bookings#sitter_confirm", as: :sitter_confirm
  patch "cancel_booking/:id", to: "bookings#cancel_booking", as: :cancel_booking
  resources :pets, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resources :bookings, only: [:new, :create]
  end
  resources :bookings, only: [:edit, :update, :destroy]
  resources :reviews, only: [:create, :index, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
