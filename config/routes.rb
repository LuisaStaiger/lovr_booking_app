Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  get 'my_bookings', to: 'user_bookings#index', as: 'user_bookings'

  resources :festivals do
    get 'check_availability', on: :member do
    end
    resources :bookings, only: [:new, :create]
    resources :love_pods, only: [:show]
  end

  resources :love_pods do
    get 'show_from_index', on: :member do
    end
  end
  resources :bookings, only: [:destroy, :index]

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
