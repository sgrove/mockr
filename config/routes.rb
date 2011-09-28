ActionController::Routing::Routes.draw do |map|

  map.resources :collaborators
  map.resources :comments, :collection => {:ajax_create => :post}
  map.resources :mocks
  map.resources :mock_lists
  map.resources :projects, :member => {:mock_list_selector => :get}
  
  map.devise_for :users
  map.resources :settings, :collection => {:general => :get, :update_all => :put, :users => :get}
 
  map.claim '/claim', :controller => :claim
  map.connect '/intro', :controller => :intro

  map.home '', :controller => 'home', :actions => 'index'
  map.usage '/usage', :controller => 'usage'
  map.root :controller => 'home', :actions => 'index'
end
