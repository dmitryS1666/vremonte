Rails.application.routes.draw do
  resources :requests, only: [:new, :create, :show, :delete] do
    resources :comments, only: [:new, :create, :show], shallow: true
  end

  root to: "requests#index"
end
