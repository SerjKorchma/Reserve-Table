Rails.application.routes.draw do


  resources :reservations, only: [:index, :create]

  root 'home#index'
end
