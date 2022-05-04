# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'engines#home'
  resources :posts

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'signout', to: 'sessions#destroy'

  resources :comments, except: %i[index show]

  post 'add_post_to_favourite/:post_id', to: 'users#favourite_post', as: 'add_post_to_favourite'
  get 'display_favourite_posts', to: 'users#display_favourite_posts'
  delete 'remove_post_from_favourites', to: 'users#remove_post_from_favourites'

  post 'add_algorithm_to_favourite/:algorithm_id', to: 'users#favourite_algorithm', as: 'add_algorithm_to_favourite'
  post 'add_datastructure_to_favourite/:datastructure_id', to: 'users#favourite_datastructure',
                                                           as: 'add_datastructure_to_favourite'

  get 'display_favourite_algorithms', to: 'users#display_favourite_algorithms'
  get 'display_favourite_datastructures', to: 'users#display_favourite_datastructures'

  delete 'remove_algorithm_from_favourites', to: 'users#remove_algorithm_from_favourites'
  delete 'remove_datastructure_from_favourites', to: 'users#remove_datastructure_from_favourites'

  post 'search', to: 'engines#search'
  get 'search', to: 'engines#home'

  get 'display_results', to: 'engines#display_results', as: 'display_results'
end
