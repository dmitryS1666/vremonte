Rails.application.routes.draw do
  resources :requests, only: [:new, :create, :show, :delete] do
    resources :comments, only: [:create], shallow: true
  end

  root to: "requests#index"
end
