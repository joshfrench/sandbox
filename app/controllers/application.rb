# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  before_filter :get_palette
  
  def get_palette
    session['palette'] ||= Palette.random
  end
  
  private :get_palette
end

class CRUDController < ApplicationController
  def index  
    instance_variable_set("@#{controller_name.pluralize}", current_model.find(:all))
  end
  
  def show
    instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id]))
  end
  
  def new
    instance_variable_set("@#{controller_name.singularize}", current_model.new)
  end
  
  def create
    instance_variable_set("@#{controller_name.singularize}", current_model.create(params_hash))
    respond_to do |wants|
      wants.html { redirect_to :action=>:index }
      wants.js
    end
  end 
  
  def edit
    instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id]))
  end
 
  def update
    object = instance_variable_set("@#{controller_name.singularize}", current_model.find(params[:id])) 
    if eval("@#{controller_name.singularize}").update_attributes(params_hash)
      respond_to do |wants|
        wants.html {redirect_to :action=>:index}
        wants.js
      end
    else
      render
    end
  end
 
  def destroy
    current_model.find(params[:id]).destroy if request.post?
    respond_to do |wants|
      wants.html { redirect_to :action => :index }
      wants.js
    end
  end

  
  private
  def current_model
      Object.const_get controller_name.classify
  end
 
  def params_hash
    params[controller_name.singularize.to_sym]
  end
end