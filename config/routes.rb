Rails.application.routes.draw do
  devise_for :users
  root to: "records#index"
  resources :records, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :lists, only: [:index]
end
