Rails.application.routes.draw do


  devise_for :users
   # controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }


  # scope '(:locale)', locale: /fr|en|it/ do

  root to: 'pages#home'
  get "users/profile", to: 'pages#profile'


  resources :weddings do
    get "tasks/upload", to: "tasks#upload"
    get "accomodations/upload", to: "accomodations#upload"
    get "registries/upload", to: "registries#upload"
    resources :reviews
    resources :registries do
      resources :vegetables, only: [:new, :create]
    end
    resources :vegetables, only: [:index]
    resources :accomodations do
      resources :accomodation_requests, only: [:new, :create]
    end
    resources :tasks do
      resources :services, only: [:new, :create, :update, :destroy]
      resources :messages, only: [:create, :index, :new, :destroy, :show]
    end
    resources :accomodation_requests, only: [ :index, :edit, :destroy ]
    resources :services, only: [:index]
  end
  resources :questions, only: [:new, :create]

  mount Attachinary::Engine => "/attachinary"
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

