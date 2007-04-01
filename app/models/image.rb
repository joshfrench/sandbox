class Image < ActiveRecord::Base
  acts_as_attachment :storage => :file_system, :max_size => 1.megabyte, :content_type => :image
  validates_as_attachment
  THUMBS = { :rounded => 120 }
  
  after_attachment_saved do |photo|
    if photo.parent_id.nil?
      THUMBS.each_pair do |file_name_suffix, size|
        thumb = thumbnail_class.find_or_initialize_by_thumbnail_and_parent_id(file_name_suffix.to_s, photo.id)
        resized_image = photo.crop_resize_and_mask_image(size)
        unless resized_image.nil?
          basename, ext = photo.filename.split '.'
          thumb.attributes = {
            :content_type => photo.content_type,
            #:filename => photo.thumbnail_name_for(file_name_suffix.to_s),
            :filename => "#{basename}_#{file_name_suffix.to_s}.gif",
            :attachment_data => resized_image
          }
          thumb.save!
        end
      end
    end
  end
  
  def crop_resize_and_mask_image(size)
    self.with_image do |img|
      img.format = "GIF"
      img.crop_resized!(size, size)
      
      shape = Magick::Image.new(120, 120)
      
      cutout = Magick::Draw.new
      cutout.stroke_width(0)
      cutout.fill('black')
      cutout.rectangle(0,0,120,120)
      cutout.draw(shape)
      cutout.fill('white')
      cutout.roundrectangle(3,3,116,116,12,12)
      cutout.draw(shape)

      shape.matte = false
      img.matte = true
      
      img.composite!(shape, 0, 0, Magick::CopyOpacityCompositeOp)
    end
  end
  
  def thumbnail_name_for(thumbnail = nil)
    return filename unless thumbnail
    basename, ext = filename.split '.'
    "#{basename}_#{thumbnail}.gif"
  end

end

class BlurbImage < Image
  belongs_to :blurb
end

class ProjectImage < Image
  belongs_to :project
end
