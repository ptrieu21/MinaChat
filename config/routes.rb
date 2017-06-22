Rails.application.routes.draw do
  

  root 'pages#home'
  resources :users, except: [:new] do
  	get 'inbox', to: 'messages#inbox'
  	get 'sent', to: 'messages#sent'
  end

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
