Rails.application.routes.draw do
  resources :requests, shallow: true do
    resources :comments, only: [:create]
  end

  root to: "requests#index"
end
