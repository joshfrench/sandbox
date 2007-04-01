ActionController::Routing::Routes.draw do |map|
  
  map.resources :projects do |projects|
    projects.resources :blurbs
  end
  
  map.resources :palettes, :users, :sessions

  map.connect ':action', :controller => 'site'
  
  map.connect '', :controller => 'projects'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  # map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  # map.connect ':controller/:action/:id'
end
