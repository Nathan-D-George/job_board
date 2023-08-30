Rails.application.routes.draw do
  get    '/sessions/new',     to: 'sessions#new',     as: 'new_session'
  post   '/sessions/create',  to: 'sessions#create',  as: 'new_user_session'
  delete '/sessions/destroy', to: 'sessions#destroy', as: 'destroy_user_session'

  resources :users ,except: [:new, :edit, :show, :destroy]
  get    '/users/new',     to: 'users#new',     as: 'new_user'
  post   '/users/create',  to: 'users#create',  as: 'new_user_registration'
  get    '/users/show',    to: 'users#show',    as: 'show_user'
  get    '/users/edit',    to: 'users#edit',    as: 'edit_user_registration'
  patch  '/users/update',  to: 'users#update',  as: 'update_user_registration'
  get    '/users/delete1', to: 'users#delete1', as: 'delete_1'
  get    '/users/delete2', to: 'users#delete2', as: 'delete_2'
  delete '/users/delete',  to: 'users#destroy', as: 'destroy_user_registration'

  get    '/users/change_password', to: 'users#edit_password',   as: 'edit_password'
  post   '/users/change_password', to: 'users#change_password', as: 'change_password'
  post   '/users/search_results',  to: 'users#search_users',    as: 'search_users'

  root           to: 'pages#home'
  get  '/about', to: 'pages#about'

end
















=begin

  Lord of my life
  Here is my heart
  Been so good
  Fear is not my future
  You really are
  Costly
  One name
  More than Able
  Firm Foundation
  Jehovah
  Yahweh
  Yahweh will Manifest
  Yeshua
  Who is this man?
  Praise (Elevation)
  Welcome Resurrection (Elevation)
  Show me your Glory
  Crowned (highlands worship, Rebecca Hart)
  All hail the Power of Jesus name

=end