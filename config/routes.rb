Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users
  get 'my_bookings', to: 'user_bookings#index', as: 'user_bookings'
  resources :festivals do
    get 'check_availability', on: :member do  # To view available time slots
      # post 'confirm_booking', on: :member    # To confirm a booking directly
    end
    resources :bookings
  end
  resources :love_pods

end
