# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :users, only: %i[show create]
  resources :login, only: %i[create]
  post 'login/auto_login'
  # root 'articles#index'
end
