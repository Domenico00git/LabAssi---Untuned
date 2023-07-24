Rails.application.routes.draw do
  get 'users/:username', to: 'users#show', as: 'user'
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
