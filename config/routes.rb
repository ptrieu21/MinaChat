Rails.application.routes.draw do
  root 'pages#home'
  resources :users, except: [:new]

  get 'signup', to: 'users#new'
end
