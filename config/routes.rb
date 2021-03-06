Rails.application.routes.draw do

  get 'wiki/all_pages' => 'wiki#show_all', :as => "wiki_pages"
  get 'wiki/new' => 'wiki#new', :as => "wiki_new"
  get 'wiki/:page_reference' => 'wiki#show', :as => "wiki_show"
  delete 'wiki/:page_reference' => 'wiki#destroy', :as => "wiki_delete"
  get 'wiki' => 'wiki#index', :as => 'wikis'
  post 'wiki' => 'wiki#create'
  get 'wiki/:page_reference/edit' => 'wiki#edit', :as => "wiki_edit"
  patch 'wiki' => 'wiki#update'

  get 'loans/search_by_sku_or_asset_tag' => 'loans#search_by_sku_or_asset_tag'
  get 'loans/lookup' => 'loans#lookup'
  patch 'loans/:id/close' => 'loans#close', :as => "close_loan"
  get 'loans/report/:id' => 'loans#report'
  resources :loans

  get 'inventory_items/new_receiving' => 'inventory_items#new_receiving', :as => "new_receiving"
  post 'inventory_items/receive' => 'inventory_items#receive', :as => "receive"
  get 'inventory_items/search_by_sku' => 'inventory_items#search_by_sku'
  get 'inventory_items/:id/enter_serial_numbers' => 'inventory_items#enter_serial_numbers', :as => "enter_serial_numbers"
  resources :inventory_items do
    get 'delete'
  end

  resources :uploads

  # Root View
  root 'static_pages#home'

  # Seach Methods
  get 'search/new' => 'searches#new', :as => 'new_search'
  get 'search/results' => 'searches#search', :as => 'search'

  # Devise Configuration
  devise_for :users
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'
  end

  # Routes for People
  resources :people do
    get 'delete'
  end

  # Routing for administrator Dashboard
  namespace :admin do
    get '', to: 'dashboard#index', as: :dashboard
    resources :users do
      get 'delete'
    end
    resources :device_groups do
      get 'delete'
      get 'add_property' => 'device_groups#add_property', as: :add_property
      get 'create_property' => 'device_groups#create_property', as: :create_property
      delete 'remove_property/:property_id' => 'device_groups#remove_property', as: :remove_property
      delete 'remove_property_all/:property_id' => 'device_groups#remove_property_from_all', as: :remove_property_from_all
    end
    resources :properties do
      get 'delete'
    end
  end

  # Routes for networks
  get 'networks/device_list' => 'networks#get_device_list', as: :get_device_list_network
  resources :networks do
    get 'add_address' => 'networks#add_address', as: :add_address
    post 'save_address' => 'networks#save_address', as: :save_address
  end


  # Routes for articles
  get 'kb/tags/:tag' => 'articles#index', as: :tag
  post 'kb/link' => 'articles#link'
  get 'kb/linkable_type' => 'articles#linkable_type_select', as: :linkable_select_article
  resources :articles, :path => "kb"

  # Routes for Logs
  resources :logs

  #Routes for attributes
  resources :attrs

  # Routes for Devices
  get 'devices/:id/attachments' => 'devices#attachments', as: :device_attachments
  get 'devices/:id/device_info' => 'devices#device_info', as: :device_info
  get 'devices/:id/history' => 'devices#history_info', as: :device_history_info
  get 'devices/:group' => 'devices#index', as: :device_types
  get 'devices/:group/new' => 'devices#new', as: :device_group_new
  get 'devices/:group/:id' => 'devices#show', as: :device_group_show
  get 'devices/:group/:id/edit' => 'devices#edit', as: :device_group_edit
  delete 'devices/:group/:id' => 'devices#destroy', as: :device_group_delete
  delete 'devices/:group/:id/clear_history' => 'devices#clear_history', as: :device_group_clear_history
  resources :devices

  # Routes for addresses
  resources :addresses



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
