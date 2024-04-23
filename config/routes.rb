Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  resources :festivals do
    get 'check_availability', on: :member  # To view available time slots
    post 'confirm_booking', on: :member    # To confirm a booking directly
  end

  resources :love_pods

  # If you don't use Booking routes for new or create actions related to festivals:
  # You might still keep it if you want a dedicated page to show or manage bookings:
  resources :bookings, only: [:create, :show]
end


