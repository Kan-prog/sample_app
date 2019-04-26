Rails.application.routes.draw do

  root 'static_pages#home'

  get '/home', to: 'static_pages#home'
  get  '/about', to: 'static_pages#about'
  get  '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :users do
    member do
      get :likes
    end
  end  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :favorites, only: [:create, :destroy]
end
