Rails.application.routes.draw do
  devise_for :users do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: "records#index"
  resources :records, only: :index
end
