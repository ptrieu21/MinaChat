Rails.application.routes.draw do  
  root 'pages#home'
  resources :users
  resources :messages
  resources :friendships, except: [:show, :delete]
  delete 'friendships', to: 'friendships#destroy'

  get 'inbox', to: 'messages#inbox'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'auth/:provider/callback' => 'sessions#callback'

end
