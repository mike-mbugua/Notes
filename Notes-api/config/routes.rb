Rails.application.routes.draw do
  resources :users
  resources :notes
  resource :users, only: [:create]
  post 'users/login', to: 'auth#create'
  get '/profile', to: 'user#profile'
end
