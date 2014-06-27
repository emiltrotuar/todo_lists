TodoLists::Application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'users/sessions',
  }
  resources :users, only: [:create, :update] do
    get :me, on: :collection
  end
  resources :projects, except: [:new, :edit] do
    post :sort, :sortp, on: :collection
  end
  resources :tasks, only: [:create, :update, :destroy]
  resources :notes, only: [:index, :create, :destroy]
  root to: 'application#index'
end
