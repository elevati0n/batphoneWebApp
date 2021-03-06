Rails.application.routes.draw do

  get 'streams/new'

  get 'streams/create'

  get 'streams/update'

  get 'streams/edit'

  get 'streams/destroy'

  resources :recordings

  resources :streams

  #get 'recordings/new'

  #get 'recordings/edit'

  #get 'recordings/show'

  #get 'recordings/index'

  #get 'networks/new'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  get 'db_manage' => 'dbmanage#db_manage'

  get 'help' => 'static_pages#help'

  get 'home' => 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'signup'  => 'users#new'

  get    'login'   => 'sessions#new'
 
  post   'login'   => 'sessions#create'


  delete 'logout'  => 'sessions#destroy'

  get 'addnetwork' => 'networks#new'

  get 'maps' => 'maps#show'

  resources :devices

  resources :networks

  resources :networks do
    resources :devices
  end

  resources :networks do
    resources :users
  end

  resources :users do
    resources :networks
  end


  get :startaudiostream, controller:"streams"

  get :startlistener, controller:"streams"

  get :tunnelToMasterFrom6, controller:"streams"

  get :Stream6Broadcasting, controller:"streams"

  get :ForwardStreamThroughNode, controller:"streams"

  get :StreamReceiving, controller:"streams"








  #  get 'registerdevice', to: 'devices#new', as: 'network'





  resources :users
  
  resources :microposts #,          only: [:create, :destroy]


  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships,       only: [:create, :destroy]

  resources :comments

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
