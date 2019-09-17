Rails.application.routes.draw do
  get 'static_pages/index'
  root to: 'static_pages#index'
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
