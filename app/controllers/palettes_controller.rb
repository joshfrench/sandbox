class PalettesController < CRUDController
  def destroy
    Palette.destroy(params[:id]) if request.delete?
    respond_to  do |wants|
      wants.html { redirect_to :action => "index" }
    end
  end
end