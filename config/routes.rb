Rails.application.routes.draw do
  devise_for :users
  # scope '(:locale)', locale: /fr|en|it/ do

  root to: 'pages#home'
  get "users/profile", to: 'pages#profile'

  resources :weddings do
    get "tasks/upload", to: "tasks#upload"
    get "accomodations/upload", to: "accomodations#upload"
    get "registries/upload", to: "registries#upload"
    resources :registries do
      resources :vegetables, only: [:new, :create]
    end
    resources :vegetables, only: [:index]
    resources :accomodations, only: [:index]
    resources :tasks do
      resources :services, only: [:new, :create, :update, :destroy]
    end
    resources :messages, only: [:create]
    resources :services, only: [:index]
    resources :discussions
  end
  resources :questions, only: [:new, :create]

  mount Attachinary::Engine => "/attachinary"
end
