Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'pets/index'
  get 'pets/:id', to: "pets#show", as: :pet
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
