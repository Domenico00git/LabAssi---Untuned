Rails.application.routes.draw do
  get 'users/:username', to: 'users#show', as: 'user'

  resources :users, only: :show, param: :username do
    member do
      get "follow", to: "follows#create"
      get "unfollow", to: "follows#destroy"
    end
  end


  resources :posts
  devise_for :users
  as:user do 
    get "signin", to: 'devise/sessions#new'
    get "signout", to: 'devise/sessions#destroy'
    get "signup", to: 'devise/registrations#new'
  end
  root 'pages#home'
  get 'contact', to: 'pages#contact'
  get "posts", to: 'posts#index'
end
