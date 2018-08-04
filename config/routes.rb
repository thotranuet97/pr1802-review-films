Rails.application.routes.draw do
  namespace :admin do
    get '/' => 'users#index'
  end

  root "pages#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
