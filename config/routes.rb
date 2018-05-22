Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    post '/users/auth/sign_up' => 'omniauth_callbacks#sign_up'
  end

  resources :requests, shallow: true do
    resources :comments, only: [:create]
  end

  mount ActionCable.server => '/cable'

  root to: "requests#index"
end
