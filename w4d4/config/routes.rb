Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
  resources :albums
  resources :tracks
  resource :notes, only: [:new, :create, :destroy]
end
