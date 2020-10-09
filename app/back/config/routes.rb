Rails.application.routes.draw do
  devise_for :users
  resources :books do
    get :search, on: :collection
  end
  root "home#top"
end
