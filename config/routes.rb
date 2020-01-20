Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories
  resources :car_models, only: [:index, :show, :new, :create, :edit, :update]
  resources :clients, only: [:index, :show, :new, :create]
  resources :cars, only: [:index, :show]
  resources :rentals, only: [:index, :show, :new, :create] do
    get 'search', on: :collection
    get 'begin', on: :member
    post 'begin', on: :member, to: 'rentals#confirm_begin'
  end
end
