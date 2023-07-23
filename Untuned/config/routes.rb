Rails.application.routes.draw do
  resources :posts
  devise_for :users
  as:user do 
    get "signin" => 'devise/sessions#new'
    get "signout" => 'devise/sessions#destroy'
    get "signup" => 'devise/registrations#new'
  end
  root 'pages#home'
  get 'contact' => 'pages#contact'
  get "posts" => 'posts#index'
end
