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



  def Stream6Broadcasting
    @network = Network.first


    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)
    `ssh -n -f -vvv -p 2222 -R 18880:root@192.168.2.6:22 root@129.10.248.216 "arecord -f cd -Dhw:sndrpiwsp | ffmpeg -fflags nobuffer -i - -acodec libmp3lame -q:a 6 -ac 2 -re -f mpegts udp://192.168.2.6:1234"`
    flash[:success] = "Broadcasting stream created at Recording Pi Node 6!"

    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network

  end

  def ForwardStreamThroughNode
    `ssh -n -f -vvv -p 2222 -R 18881:root@192.168.2.6:22 root@129.10.248.216 " ffmpeg -i udp://192.168.2.7:1234 -acodec copy -f mpegts udp://192.168.2.8:1234`
    flash[:success] = "Forwarding audio stream from Recording Pi .7 to Recording Pi .8"

    @network = Network.first
    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network
  end


  def CreateStreamDeviceRecieving
    `ssh -n -f -vvv -p 2222 -R 18880:root@192.168.2.6:22 root@129.10.248.216 " ffplay -fflags nobuffer -nodisp -f mpegts -i udp://192.168.2.6:1234`
    flash[:success] = "Recording Pi 8 is now recieving the audio stream"

    @network = Network.first
    @stream = Stream.new(:network_id => 1, :port => "18886", :device_id => 6)

    redirect_to @network
  end







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
