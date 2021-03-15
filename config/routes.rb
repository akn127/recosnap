Rails.application.routes.draw do
  devise_for :users
  root to: "records#index"
  resources :records do
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy]
  end
  resources :lists, only: [:index, :show]
  resources :users
end
