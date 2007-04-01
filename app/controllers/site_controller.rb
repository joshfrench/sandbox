class SiteController < ApplicationController
  def index; end
  
  def change_palette
    session['palette'] = nil
    redirect_to :controller => "projects", :action => "index"
  end
  
end
