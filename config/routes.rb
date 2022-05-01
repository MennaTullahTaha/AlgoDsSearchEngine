Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'engines#index'
  get '/posts/:id', to: 'posts#show', as: 'post'
  get '/posts', to: 'posts#index', as: 'posts'

end
