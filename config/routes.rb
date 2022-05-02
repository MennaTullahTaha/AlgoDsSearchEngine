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

  get 'add_post_to_favourite/:post_id', to: 'users#favourite_post', as: 'add_post_to_favourite'
  get 'display_favourite_posts', to: 'users#display_favourite_posts'
  delete 'remove_post_from_favourites', to: 'users#remove_post_from_favourites'

  post 'search', to: 'engines#search'

  get 'search', to: 'engines#index'

end
