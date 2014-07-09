TodoLists::Application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'users/sessions',
  }
  get '/users/me', to: 'users#me'
  resources :projects, except: [:new, :edit, :show] do
    post :sort, :sortp, on: :collection
  end
  resources :tasks, only: [:create, :update, :destroy]
  resources :notes, only: [:index, :create, :destroy]
  root to: 'application#index'
end
