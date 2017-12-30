Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }

  scope '(:locale)', locale: /fr|en|it/ do
    root to: 'pages#home'
    get "users/profile", to: 'pages#profile'

    resources :weddings do
      resources :registries
      resources :reviews
      resources :tasks do
        resources :elements, only: [:index, :create, :show, :edit, :update, :destroy ]
        resources :messages, only: [:create, :index, :new, :destroy, :show]
      end
    end

    mount Attachinary::Engine => "/attachinary"
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

