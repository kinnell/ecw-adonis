Adonis::Application.routes.draw do

  devise_for :users
  resources :users

  resources :teams
  resources :weighins

  # devise_for :users, :controllers => { :sessions => 'users/sessions' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  authenticated :user do
    root :to => "weighins#myProgress", as: :authenticated_root
  end
    root :to => "pages#home"

  get "weighins/:id/verify" => "weighins#verify", :as => "verify_weighin"
  get "weighins/:id/unverify" => "weighins#unverify", :as => "unverify_weighin"

  get "teams/:id/join" => "teams#join", :as => "join_team"
  get "teams/:id/leave" => "teams#leave", :as => "leave_team"

  get "leaderboard", to: "pages#leaderboard"
  get "treasury", to: "pages#treasury"
  get "dashboard", to: "pages#dashboard"
  get "myteam", to: "teams#myTeam"
  get "changelog", to: "pages#changelog"

  get 'users/:id' => 'users#show'
  get "users/:id/promote" => "users#promote", :as => "promote_user"
  get "users/:id/demote" => "users#demote", :as => "demote_user"
  get "users/:id/hasPaid" => "users#hasPaid", :as => "hasPaid_user"
  get "users/:id/hasNotPaid" => "users#hasNotPaid", :as => "hasNotPaid_user"
  get "users/:id/destroyUser" => "users#destroyUser", :as => "destroy_user"


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
