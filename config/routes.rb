Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to:'static_pages#top'
  get 'serveice', to: 'static_pages#service'
  get 'login', to: 'user_sessions#new'
  post 'login',to: 'user_sessions#create'
  delete 'login',to: 'user_sessions#destroy'
  post 'guest_login', to: 'user_sessions#guest_login'

  resources :users, only: %i[new create]
  resources :clothes, only: %i[index] do
    member do
      post 'set'
    end
    collection do
      get 'search'
    end
  end
  resources :myclosets do
    member do
      get 'select'
      get 'publish'
    end
    collection do
      get 'search'
    end
  end
end
