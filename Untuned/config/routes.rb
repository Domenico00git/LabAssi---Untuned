Rails.application.routes.draw do
  get 'topics/index'
  get 'profiles/index'

  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users 

  as:user do
    get 'deleteuser', to:'devise/registrations#destroy'
  end


  resources :users, only: :show, param: :username do
    member do
      get 'follow', to: 'follows#create1'
      get 'unfollow', to: 'follows#destroy1'
      get 'users/:username', to: 'users#show'
    end
  end

  resources :posts do
    member do
      get 'like', to: 'votes#createlike'
      get 'unlike', to: 'votes#destroylike'

      get 'dislike', to: 'votes#createdislike'
      get 'undislike', to: 'votes#destroydislike'

      get 'followpost', to: 'follows#create2'
      get 'unfollowpost', to: 'follows#destroy2'

      get 'enable_comments', to: 'posts#enable_comments'
      get 'disable_comments', to: 'posts#disable_comments'

    end

    resources :comments do
      member do
        get 'like', to: 'votes_comment#createlike'
        get 'unlike', to: 'votes_comment#destroylike'
  
        get 'dislike', to: 'votes_comment#createdislike'
        get 'undislike', to: 'votes_comment#destroydislike'
      end
    end
  end

  root 'pages#home'
  get 'contact', to: 'pages#contact'
  get 'posts', to: 'posts#index'
  get 'oldest_posts', to: 'posts#oldest'
  get 'newest_following_posts', to: 'posts#newest_following'
  get 'oldest_following_posts', to: 'posts#oldest_following'
  get 'admin', to: 'root#admin'

  get 'followers', to: 'users#followers'
  get 'following', to: 'users#following'

end
