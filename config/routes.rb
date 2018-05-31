Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    post '/users/auth/sign_up' => 'omniauth_callbacks#sign_up'
  end

  resources :users

  resources :requests, shallow: true do
    resources :comments, only: [:create]
    resources :answers, only: [:create]
  end

  # namespace :api do
  #   namespace :v1 do
  #     resource :profiles, only: :index do
  #       get :me, on: :collection
  #     end
  #   end
  # end

  mount ActionCable.server => '/cable'

  root to: "requests#index"
end
