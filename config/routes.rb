TodoLists::Application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'users/sessions',
  }

  resources :notes, except: [:new, :edit]

  resources :users, except: [:show, :index] do
    get :me, on: :collection
  end

  resources :projects, except: [:new, :edit] do
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
