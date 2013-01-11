OpenescalarAmun::Application.routes.draw do
 
  #pagination

  match 'firewalls/pages/:page' => 'firewalls#index', :via => [:get]
  match 'infrastructures/pages/:page' => 'infrastructures#index', :via => [:get]
  match 'deployments/pages/:page' => 'deployments#index', :via => [:get]
  match 'workflows/pages/:page' => 'workflows#index', :via => [:get]
  match 'roletasks/pages/:page' => 'roletasks#index', :via => [:get]
  match 'roles/pages/:page' => 'roles#index', :via => [:get]
  match 'rules/pages/:page' => 'rules#index', :via => [:get]
  match 'servers/pages/:page' => 'servers#index', :via => [:get]
  match 'volumes/pages/:page' => 'volumes#index', :via => [:get]
  match 'zones/pages/:page' => 'zones#index', :via => [:get]
  match 'offers/pages/:page' => 'offers#index', :via => [:get]
  match 'images/pages/:page' => 'images#index', :via => [:get]
  #match 'loadbalancers/pages/:page' => 'loadbalancers#index', :via => [:get]
  #match 'distros/pages/:page' => 'distros#index', :via => [:get]
  match 'accounts/pages/:page' => 'accountss#index', :via => [:get]
  match 'users/pages/:page' => 'usrss#index', :via => [:get]
  match 'events/pages/:page' => 'events#index', :via => [:get]

  #end pagination
 
  #Home and Login

  get "home/index"
  get "home/login"
  get "home/forgotpassword"
  post "home/forgotpassword"
  post "home/login"
  get "home/logout"

  #end Home and Login

  #Extra formm options that get updated with jquery
  
  match 'zones/enable' => 'zones#enableCloud', :via => [:post]
  match 'zones/serverbyoffer' => 'zones#serverbyoffer', :via => [:get]
  match 'zones/serverbyimage' => 'zones#serverbyimage', :via => [:get]
  match 'zones/costbyzone' => 'zones#costbyzone', :via => [:get]
  #match 'zones/:id/import' => 'zones#importResources', :via => [:post]
  #match 'keypairs/:id/import/:zid' => 'keypairs#import', :via => [:post]
  match 'keypairs/:id/download' => 'keypairs#download', :via => [:get]
  match 'servers/update_zone_select/:id', :controller => 'servers', :action => 'update_zone_select'
  match 'volumes/update_zone_select/:id', :controller => 'volumes', :action => 'update_zone_select'
  match 'images/update_zone_select/:id', :controller => 'images', :action => 'update_zone_select'
  match 'firewalls/update_zone_select/:id', :controller => 'firewalls', :action => 'update_zone_select'
  match 'keypairs/update_zone_select/:id', :controller => 'keypairs', :action => 'update_zone_select'
  match 'loadbalancers/update_zone_select/:id', :controller => 'loadbalancers', :action => 'update_zone_select'
  match 'workflows/addtask', :controller => 'workflows', :action => 'addtask', :via => [:post]
  match 'workflows/deltask', :controller => 'workflows', :action => 'deltask', :via => [:post]
  match 'servers/:id/getlog', :controller => 'servers', :action => 'getlog', :via => [:get]

  #end Extra form jquery options

  #Execute tasks

  match 'deployments/deploy', :controller => 'deployments', :action => 'deploy', :via => [:post]
  match 'deployments/deployworkflow', :controller => 'deployments', :action => 'deployworkflow', :via => [:post]
  match 'servers/:id/taskexec/:roletask_id', :controller => 'servers', :action => 'taskexec', :via => [:post]
  match 'roles/:id/roleexec/:roletask_id', :controller => 'roles', :action => 'roleexec', :via => [:post]
  match 'infrastructures/:id/build', :controller => 'infrastructures', :action => 'build', :via => [:post]

  #Execute tasks 

  match 'accounts/:id', :controller => 'accounts', :action => 'show', :via => [:get]
  match 'events/show/:ident' => 'events#show', :via => [:get]
  match 'events/getevent', :controller => 'events', :action => 'getevent' , :via => [:get]
  match 'users/:id/edit', :controller => 'users', :action => 'edit', :via =>[:get]
  match 'users/:id', :controller => 'users', :action => 'show', :via =>[:get]
  match 'users/:id', :controller => 'users', :action => 'update', :via =>[:put]
  match 'users/achange/:id' => 'users#achange', :via => [:get]
  get "users/achange"
  match 'users/invite' => 'users#invite', :via => [:get]
  match 'users/invite/:id' => 'users#invite', :via => [:post]
  get "user/invite"
  post "users/invite"
  scope "/administrator" do
    resources :accounts, :users
  end

  # Resources

  resources :zones
  resources :offers
  resources :infrastructures
  resources :deployments
  resources :roles
  resources :rules, :except => [:edit, :update]
  resources :firewalls, :except => [:edit, :update]
  resources :volumes, :except => [:edit, :update]
  resources :images
  resources :servers
  resources :roletasks
  resources :keypairs
  resources :workflows
  resources :events, :only => [:index]

  # Resources for future implementation
  #resources :distros
  #resources :loadbalancers
  #resources :vpns

  #End Resources

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root :to => 'home#index'

end
