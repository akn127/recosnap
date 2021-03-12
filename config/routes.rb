Rails.application.routes.draw do
  devise_for :users
  root to: "records#index"
  resources :records do
    collection do
      get 'search'
    end
  end
  resources :lists, only: [:index]
end
