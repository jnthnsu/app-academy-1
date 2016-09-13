Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: :index do
    member do
      resources :comments, only: :new
    end
  end
  resources :comments, only: [:create, :show]
end
