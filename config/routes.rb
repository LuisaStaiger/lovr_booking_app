Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  resources :festivals do
    resources :bookings, only: [:new, :create, :show]
    get 'check_availability', on: :member  # To view available time slots
    post 'confirm_booking', on: :member    # To confirm a booking directly
  end

  resources :love_pods

end
