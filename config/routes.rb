Rails.application.routes.draw do
  devise_for :users
  resources :requests, shallow: true do
    resources :comments, only: [:create]
  end

  mount ActionCable.server => '/cable'

  root to: "requests#index"
end
