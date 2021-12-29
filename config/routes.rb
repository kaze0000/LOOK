Rails.application.routes.draw do
  root to:'static_pages#top'
  get 'login', to: 'user_session#new'
end
