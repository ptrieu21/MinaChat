Rails.application.routes.draw do
  

  root 'pages#home'
  resources :users
  resources :messages

  get 'inbox', to: 'messages#inbox'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
