Rails.application.routes.draw do
  resources :comments, except: [:new, :edit, :show, :destroy]
  post   '/comments/create',  to: 'comments#create',  as: 'create_comment'
  get    '/comments/edit',    to: 'comments#edit',    as: 'edit_comment'
  get    '/comments/list',    to: 'comments#list',    as: 'list_comments'
  patch  '/comments/update',  to: 'comments#update',  as: 'update_comment'
  delete '/comments/destroy', to: 'comments#destroy', as: 'destroy_comment'

  post   '/likes/create',  to: 'likes#create',  as: 'like'
  delete '/likes/destroy', to: 'likes#destroy', as: 'unlike'
  
  resources :posts, except: [:new, :edit, :show, :destroy]
  get    '/posts/new',     to: 'posts#new',     as: 'new_post'
  post   '/posts/create',  to: 'posts#create',  as: 'create_post'
  get    '/posts/show',    to: 'posts#show',    as: 'show_post'
  get    '/posts/list',    to: 'posts#list',    as: 'list_posts'
  get    '/posts/edit',    to: 'posts#edit',    as: 'edit_post'
  patch  '/posts/update',  to: 'posts#update',  as: 'update_post'
  delete '/posts/destroy', to: 'posts#destroy', as: 'destroy_post'

  post   '/friendships/create', to: 'friendships#create', as: 'follow'
  delete '/friendships/delete', to: 'friendships#delete', as: 'unfollow'
    
  get '/notifications/list', to: 'notifications#list', as: 'list_notifications'

  get    '/enlistments/list',    to: 'enlistments#list',    as: 'list_applications'  
  post   '/enlistments/create',  to: 'enlistments#create',  as: 'create_application'  
  delete '/enlistments/destroy', to: 'enlistments#destroy', as: 'destroy_application'  
  get    '/enlistments/review',  to: 'enlistments#review',  as: 'review_application'   
  post   '/enlistments/invite',  to: 'enlistments#invite',  as: 'invite_for_interview'
  post   '/enlistments/reject',  to: 'enlistments#reject',  as: 'reject_applicant'
  post   '/enlistments/reconsider' , to: 'enlistments#reconsider', as: 'reconsider_applicant' 

  resources :profiles, except: [:new, :edit, :show, :destroy]
  get   '/profiles/new',     to: 'profiles#new',    as: 'new_profile'
  post  '/profiles/create',  to: 'profiles#create', as: 'create_profile'
  get   '/profiles/edit',    to: 'profiles#edit',   as: 'edit_profile'
  patch '/profiles/update',  to: 'profiles#update', as: 'update_profile'

  resources :jobs, except: [:new, :edit, :show, :destroy]
  get    '/job/new',     to: 'jobs#new',     as: 'new_job'
  post   '/job/create',  to: 'jobs#create',  as: 'create_job'
  get    '/job/show',    to: 'jobs#show',    as: 'show_job'
  get    '/job/list',    to: 'jobs#list',    as: 'list_jobs'
  get    '/job/edit',    to: 'jobs#edit',    as: 'edit_job'
  patch  '/job/update',  to: 'jobs#update',  as: 'update_job'
  delete '/job/destroy', to: 'jobs#destroy', as: 'destroy_job'

  resources :companies, except: [:new, :edit, :update, :show, :destroy]
  get    '/companies/new',      to: 'companies#new',                 as: 'new_company'
  post   '/companies/create',   to: 'companies#create',              as: 'create_company'
  get    '/companies/show',     to: 'companies#show',                as: 'show_company'
  get    '/companies/edit',     to: 'companies#edit',                as: 'edit_company'
  patch  '/companies/update',   to: 'companies#update',              as: 'update_company'
  delete '/companies/delete',   to: 'companies#delete',              as: 'delete_company'
  get    '/companies/list',     to: 'companies#list',                as: 'list_companies'
  get    '/companies/new_user', to: 'companies#new_company_user',    as: 'new_company_user'
  post   '/companies/new_user', to: 'companies#create_company_user', as: 'create_company_user'

  get  '/searches/search',  to: 'searches#search',  as: 'search'
  post '/searches/results', to: 'searches#results', as: 'search_results'

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

  root           to: 'pages#home'
  get  '/about', to: 'pages#about'

end

=begin

  the Joy belonging co
  So good planetshakers

  Lord of my life
  Here is my heart
  You will be saved
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