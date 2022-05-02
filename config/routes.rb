Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'engines#index'
  resources :posts

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :comments, except: [:index, :show]
end
