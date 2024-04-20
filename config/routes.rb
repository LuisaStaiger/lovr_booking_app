Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users

  resources :festivals do
    # If 'time_slots' are just viewing available slots, it can stay within festivals
    get 'check_availability', on: :member
  end

  resources :love_pods

  # Separate routes for bookings
  resources :bookings, only: [:new, :create, :show] do
    collection do
      post 'search_available_pods'  # Assuming you want to handle the pod searching separately
    end
  end
end



