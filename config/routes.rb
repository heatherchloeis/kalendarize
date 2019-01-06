Rails.application.routes.draw do
	root   	'static#home'
  get   	'/about',								to: "static#about"
  get   	'/developer',						to: "static#developer"
  get   	'/help',								to: "static#help"
  get   	'/tutorial',						to: "static#tutorial"

  get	  	'/signup',							to: "users#new"
  post	  '/signup',							to: "users#create"

  get     '/login',								to: "sessions#new"
  post    '/login',								to: "sessions#create"
  delete  '/logout',							to: "sessions#destroy"

  resources :users do 
    member do 
      get :following, :followers
    end
  end
  resources :streams
  resources :user_activations,    only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end