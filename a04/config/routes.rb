TodoApp::Application.routes.draw do
  resources :users
  resources :todo_lists
  resources :todo_items
  resource :session, only: [:new, :create, :destroy]
end
