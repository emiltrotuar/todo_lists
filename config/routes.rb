TodoLists::Application.routes.draw do
  resources :notes

  resources :users, except: :index
  resources :projects do
    post :sort, :sortp, on: :collection
  end
  resources :tasks
  
  resources :sessions,   only: [:new, :create, :destroy]
  root to: 'application#index'
  match '/signup',   to: 'users#new', via: :get
  match '/signin',   to: 'sessions#new', via: :get
  match '/sessions', to: 'sessions#create', via: :post
  match '/signout',  to: 'sessions#destroy', via: :delete
end
