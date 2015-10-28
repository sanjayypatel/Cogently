Rails.application.routes.draw do
  devise_for :users, :controllers => {:invitations => "invitations"}
  resources :users, only: [:update, :show] do
    resources :feeds, only: [:create, :update, :show, :index]
  end
  patch 'users/:id/invite' => 'users#invite', as: 'invite_user'
  patch 'users/:id/deny' => 'users#deny', as: 'deny_invitation'
  resources :organizations, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :memberships, only: [:create, :destroy, :update]
    resources :documents, only: [:index, :show, :new, :create, :edit, :update]
  end
  resources :documents, only: [] do
    resources :paragraphs, only: [:create]
    resources :summaries, only: [:create, :update, :show]
  end
  resources :paragraphs, only: [] do
    resources :notes, except: [:index, :show]
  end
  resources :tags, only: [:show]
  root to: 'welcome#index'
end
