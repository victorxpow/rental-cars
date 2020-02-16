Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models
  resources :clients
  resources :cars
  resources :rentals, only: %i[index show new create] do
    get 'search', on: :collection
    get 'begin', on: :member
    post 'begin', on: :member, to: 'rentals#confirm_begin'
  end

  namespace 'api' do
    namespace 'v1' do
      resources :cars, only: %i[index show create]
    end
  end
end
