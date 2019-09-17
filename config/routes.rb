Rails.application.routes.draw do
  root to: 'static_pages#root'
  
  namespace :api, defaults: {format: :json} do
    resources :users, only: [:create, :show] do
      resources :memberships
    end
    resource :session, only: [:create, :destroy]
    resources :groups do
      resources :memberships
      resources :posts do
        resources :comments
      end
    end
  end
end
