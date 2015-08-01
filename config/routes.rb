require 'sidekiq/web'
USERNAME_FORMAT = /[A-Za-z0-9.\-_]+/

Rails.application.routes.draw do
  mount PgHero::Engine, at: "pghero"
  mount Sidekiq::Web, at: "/sidekiq"

  devise_for :users, controllers: { sessions: 'sessions' }, skip: [:passwords]

  namespace :api do
    namespace :v1 do

      get 'users/me' => 'users#me'
      get 'users' => 'users#index'
      get 'users/:username' => 'users#show', constraints: { username: USERNAME_FORMAT }

      get 'posts' => 'posts#show'
      get 'posts/:id' => 'posts#show'
      post 'posts' => 'posts#create'

      post 'friends' => 'friends#create'

      # Password reset stuff
      post 'password_reset' => 'users#start_password_reset'
      put 'password_reset' => 'users#finish_password_reset'

    end
  end

  get 'password_reset' => 'application#index', as: :edit_user_password
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
