Rails.application.routes.draw do

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'rankings/code', to: 'rankings#code'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :codes
      get :followings
      get :followers
      get :favorites
    end
  end
  
  resources :posts, only: [:new, :create, :destroy] do
    member do
      get :download
    end
  end
  resources :codes, only: [:new, :create, :destroy] do
    member do
      get :download
    end
    collection do
      get :input_search
      get :search
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :user_posts, only: [:create, :destroy]
  resources :user_codes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end
