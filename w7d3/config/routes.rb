Rails.application.routes.draw do
  namespace :api do
    resources :todos, only: [:index, :update, :create, :destroy]
  end
  resources :static_pages, only: :root

  root to: 'static_pages#root'
end
