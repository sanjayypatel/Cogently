Rails.application.routes.draw do
  devise_for :users, :controllers => {:invitations => "invitations"}
  resources :users, only: [:update, :show]
  patch 'users/:id/invite' => 'users#invite', as: 'invite_user'
  resources :organizations, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :memberships, only: [:create, :destroy, :update]
  end
  root to: 'welcome#index'
end
