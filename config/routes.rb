Rails.application.routes.draw do

  get 'messages/index'

  get 'messages/create'

  get 'messages/destroy'

  get 'chat_messages/index'

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
    resources :messages, only: [:index, :create, :destroy]
    member do
      get :likes
    end
  end  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:new, :create, :edit, :update, :destroy, :show]
  resources :favorites, only: [:create, :destroy]
end
