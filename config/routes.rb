Rails.application.routes.draw do


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }


  # scope '(:locale)', locale: /fr|en|it/ do

  root to: 'pages#home'
  get "users/profile", to: 'pages#profile'


  resources :weddings do
    get "tasks/upload", to: "tasks#upload"
    get "accomodations/upload", to: "accomodations#upload"
    resources :reviews
    resources :registries
    resources :accomodations do
      resources :accomodation_requests, only: [:new, :create, :index]
    end
    resources :tasks do
      resources :services
      resources :elements, only: [:index, :create, :show, :edit, :update, :destroy ]
      resources :messages, only: [:create, :index, :new, :destroy, :show]
    end
  end
  resources :questions, only: [:new, :create]

  mount Attachinary::Engine => "/attachinary"
  # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

