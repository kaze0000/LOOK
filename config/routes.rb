Rails.application.routes.draw do
  root to:'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login',to: 'user_sessions#create'
  delete 'login',to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :clothes, only: %i[index update]
  resources :myclosets do
    member do
      get 'select'
    end
    collection do
      get 'search'
    end
  end
end
