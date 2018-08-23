Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  namespace :admin do
    get "/", to: "users#index"
    resources :users
    resources :films, except: [:show] do
      resource :review
    end
    resources :categories, except: [:show, :new]
    resources :reviews, only: [:index]
  end
  root "pages#home"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  get "signup", to: "users#new"
  post "signup", to: "users#create"

  resources :films, only: [:show]
  resources :reviews, only: [:show] do
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy] do
    resources :comments, only: [:create]
  end
  resources :ratings
  resources :categories, only: [:show]
end
