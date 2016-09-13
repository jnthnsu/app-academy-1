Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    member do
      post 'approve!', to: 'cat_rental_requests#approve!', as: "approve"
      post 'deny!', to: 'cat_rental_requests#deny!', as: "deny"
    end
  end
end
