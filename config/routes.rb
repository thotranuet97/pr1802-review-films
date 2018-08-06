Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "pages#home"
  namespace :admin do
    get "/" => "users#index"
    resources :categories
    resources :films
  end

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  get "signup", to: "users#new"
  post "signup", to: "users#create"
end
