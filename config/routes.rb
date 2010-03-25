ActionController::Routing::Routes.draw do |map|
  map.resources :articles, :has_many => :comments
  map.resources :users, :member => {:change => :get, :confirm => :put}
  map.resource :user_session
  map.root :controller => "articles", :action => "index"
end
