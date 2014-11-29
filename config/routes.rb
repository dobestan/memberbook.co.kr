require 'sidekiq/web'

Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  match '/about', to: 'welcome#about', via: :GET
  match '/send_sms', to: 'messages#send_sms', via: :GET
  match '/test', to: 'messages#index', via: :GET
  match '/result', to: 'messages#result',via: :GET
  match '/email', to: 'messages#send_email',via: :GET

  match '/dashboard', to: 'dashboard#index', via: :GET
  match '/dashboard/:group_code/:group_id/users', to: 'dashboard#users', via: :GET

  # Sidekiq DashBoard
  mount Sidekiq::Web, at: '/sidekiq'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users

  # Example subdomain routes
  # constraints subdomain: 'dashboard' do
  #   resources :photos
  # end

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
