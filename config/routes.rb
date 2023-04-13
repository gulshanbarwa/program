Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :admin do
    resources :users
  end # <-- close the namespace block
  
  root "daff#index"

  get "create" => "daff#new"
  post "create" => "daff#create"
  get "login" => "daff#login"
  post "login" => "daff#login_attempt"
  get "logout" => "daff#logout"
  get "data" => "daff#data_new"
  post "data" => "daff#data"
  get "show" => "daff#show"
end