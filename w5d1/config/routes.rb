Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :goals do
    member do
      get 'change_complete'
      get 'cheer'
    end
  end
  resources :comments, only: :create

  root to: "users#index"
end
