Rails.application.routes.draw do
  
  get 'messages/index'

  get 'messages/create'

  get 'messages/destroy'

  get 'chat_messages/index'
  
  root 'microposts#index'

  get '/home', to: 'static_pages#home'
  get  '/about', to: 'static_pages#about'
  get  '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  # get '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  delete '/logout',  to: 'sessions#destroy'
  get  '/contact_index' =>'contacts#index'
  post '/contact_confirm' => 'contacts#confirm'
  post '/contact_done' => 'contacts#done'
  
  resources :users do
    resources :messages, only: [:index, :create, :destroy] do
      collection do
        get :your_message
      end
    end
    member do
      get :likes
    end
  end  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    member do
       get :update_sold
       put :update_sold
    end
    collection do
      match 'search' => 'microposts#search', via: [:get, :post], as: :search
    end  
  end  
  resources :favorites, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]
end
