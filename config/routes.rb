Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  get 'my_bookings', to: 'user_bookings#index', as: 'user_bookings'
  resources :festivals do
    get 'check_availability', on: :member do
    end
    resources :bookings, only: [:new, :create, :show]
  end

  resources :love_pods
  resources :bookings, only: [:destroy]
end
