Rails.application.routes.draw do
  devise_for :users, :controllers => {:invitations => "invitations"}
  resources :users, only: [:update, :show] do
    resources :feeds, only: [:create, :update, :show, :index, :destroy]
  end
  patch 'users/:id/invite' => 'users#invite', as: 'invite_user'
  patch 'users/:id/deny' => 'users#deny', as: 'deny_invitation'
  resources :organizations, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :memberships, only: [:create, :destroy, :update]
    resources :documents, only: [:index, :show, :new, :create, :edit, :update]
    resources :events
  end
  patch 'organizations/:organization_id/event/:id/add' => 'events#add_attendee', as: 'add_attendee'
  patch 'organizations/:organization_id/event/:id/remove' => 'events#remove_attendee', as: 'remove_attendee'
  patch 'organizations/:organization_id/event/:id/reference' => 'events#add_reference', as: 'add_reference'
  patch 'organizations/:organization_id/event/:id/dereference' => 'events#remove_reference', as: 'remove_reference'
  resources :documents, only: [] do
    resources :paragraphs, only: [:create]
    resources :summaries, only: [:create, :update, :show]
  end
  resources :paragraphs, only: [] do
    resources :notes, except: [:index, :show]
  end
  root to: 'welcome#index'
end
