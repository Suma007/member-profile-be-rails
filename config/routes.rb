# frozen_string_literal: true

Rails.application.routes.draw do
  resources :members do
    get 'find_people_you_may_know', on: :member
  end

  post 'members/:id/add_friend', to: 'members#add_friend'

  get '/headings/search', to: 'headings#search'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  resources :sessions, only: %i[new create destroy]
end
