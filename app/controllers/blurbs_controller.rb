class BlurbsController < CRUDController
  
  before_filter :get_current_project
  undef_method :index
  model :image
  
  def create
    @blurb = Blurb.new(params[:blurb])
    @blurb.image = BlurbImage.create!(params[:image]) if params[:image][:uploaded_data].size > 0
    @project.blurbs << @blurb
    respond_to do |wants|
      wants.html { redirect_to edit_project_path(@blurb.project.id) }
    end
  end
  
  def edit
    super
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @blurb = Blurb.find(params[:id])
    if @blurb.update_attributes(params[:blurb])
      respond_to do |format|
        format.js
      end
    else
      
    end
  end
  
  def destroy
    Blurb.find(params[:id]).destroy if request.xhr?
    respond_to do |wants|
      wants.js
    end
  end
  
  def get_current_project
    @project = Project.find(params[:project_id])
  end
  
  private :get_current_project
  
end
