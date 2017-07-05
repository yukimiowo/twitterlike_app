Rails.application.routes.draw do
  resources :sessions,  only: [:new]

  resources :users do
    member do
      get :followings, :followers
    end
  end

  root 'static_pages#home'
  get :help, to: 'static_pages#help'
  get :about, to: 'static_pages#about'
  get :signup, to: 'users#new'
  get :login, to: 'sessions#new'
  post :login, to:'sessions#create'
  delete :logout, to: 'sessions#destroy'
 
  resources :microposts,      only: [:create, :destroy] do
    resources :responses,       only: [:new, :create, :destroy]
  end
  resources :relationships,   only: [:create, :destroy]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
