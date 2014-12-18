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

  match '/login', to: 'welcome#login', via: :GET
  # Dashboard
  match '/dashboard', to: 'dashboard#index', via: :GET

  # Product 즉, 모바일 & 태블릿 뷰
  match '/product', to: 'product#index', via: :GET
  match '/product/boards', to: 'product#boards', via: :GET
  match '/product/users', to: 'product#users', via: :GET
  
  # Group routes
  match '/:group_code/:group_id/users', to: 'group#users', via: :GET
  match '/:group_code/:group_id/groups', to: 'group#create', via: :POST
  match '/groups/:group_id', to: 'group#destroy', via: :DELETE
  match '/groups/:group_id', to: 'group#update', via: :PUT

  # User routes
  match '/:group_code/users', to: 'user#users', via: :GET
  match '/:group_code/:group_id/users', to: 'user#create', via: :POST
  match '/users/:user_id', to: 'user#destroy', via: :DELETE
  match '/:group_code/get_confirm_number', to: 'user#get_confirm_number', via: :GET
  match '/confirm', to: 'user#confirm', via: :POST

  # Board routes
  match '/:group_code/boards', to: 'board#create', via: :POST
  match '/:group_code/boards', to: 'board#boards', via: :GET
  match '/:group_code/boards/:board_id', to: 'board#show', via: :GET

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
