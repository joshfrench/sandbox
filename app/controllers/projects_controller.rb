class ProjectsController < CRUDController
  model :image
  
  def create
    @project = Project.new(params[:project])
    @project.image = ProjectImage.create!(params[:image]) if params[:image][:uploaded_data].size > 0
    @project.save!
    respond_to do |wants|
      wants.html { redirect_to projects_path }
    end
  end
  
  def show
    @project = Project.find_by_slug(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to edit_project_path(params[:id])
    else
      
    end
  end
  
end
