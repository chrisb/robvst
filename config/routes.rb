# require 'lib/shared/subdomain'

Robvst::Application.routes.draw do
  devise_for :users

  devise_scope :user do
     get '/logout' => 'devise/sessions#destroy'
   end

  resources :users, :only => :show

  constraints(Subdomain) do
    get '/'                => 'posts#index', as: :user_blog
    get '/posts(.:format)' => 'posts#index'
    get '/posts.rss'       => 'posts#index', as: 'rss'
    get '/admin'           => 'posts#admin', as: 'admin'
    resources :posts
  end

  # get '/logout' => 'devise/sessions#destroy', as: 'logout'
  root :to => "pages#index"

  # resources :users do
  #   resources :posts
  # end

  # Admin
  # get '/admin' => 'posts#admin', as: 'admin'
  # get '/logout' => 'sessions#destroy', as: 'logout'

  # get '/posts(.:format)' => 'posts#index'
  # get '/posts.rss' => 'posts#index', as: 'rss'

  # resources :users
  # resources :sessions
  # resources :posts, path: '/'

  # get '/:slug' => 'posts#show', as: 'post_slug'

  # root to: 'posts#index'


  # root to: 'pages#index'

end