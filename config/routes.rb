Rails.application.routes.draw do
  devise_for :users
  root 'microposts#index'
  resources :users
  resources :microposts, only: [:create, :destroy]
end
