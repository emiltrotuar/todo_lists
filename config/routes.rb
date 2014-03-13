TodoLists::Application.routes.draw do
  resources :notes


  use_doorkeeper

  resources :users, except: :index
  resources :projects do
   post :sort, :sortp, on: :collection
  end
  resources :tasks
  
  resources :sessions,   only: [:new, :create, :destroy]
  root to: 'projects#index'
  match '/signup',   to: 'users#new'
  match '/signin',   to: 'sessions#new'
  match '/sessions', to: 'sessions#create'
  match '/signout',  to: 'sessions#destroy', via: :delete
end
