Rails.application.routes.draw do
  root "festivals#index"
  devise_for :users
  resources :festivals
  resources :love_pods
end
