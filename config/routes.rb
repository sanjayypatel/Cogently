Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update]
  resources :organizations, only: [:show, :new, :create, :edit, :update, :destroy]
  root to: 'welcome#index'
end
