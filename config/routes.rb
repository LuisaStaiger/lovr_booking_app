Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users
  resources :festivals do
    resources :love_pods, except: [:index] # Assuming you don't want a standalone LovePod index page
  end
end
