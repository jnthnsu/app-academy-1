Rails.application.routes.draw do
  resources :users, only: [:index, :create, :show, :update, :destroy] do
    member do
      get 'favorites'
      get 'contacts'
    end
  end
  resources :contacts, only: [:create, :show, :update, :destroy]
  resources :contact_shares, only: [:create, :destroy]

  # get '/users/:user_id/contacts' => 'users#index_contacts'

  resources :comments, only: [:index, :create, :show, :update, :destroy]
end
