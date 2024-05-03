Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  resources :festivals do
    get 'check_availability', on: :member do  # To view available time slots
      # post 'confirm_booking', on: :member    # To confirm a booking directly
    end
    resources :bookings, only: [:new, :create, :show]
  end

  resources :love_pods, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :bookings, only: [:destroy]
end
