require 'RMagick'
class Palette < ActiveRecord::Base
  
  def frame_filename
    RAILS_ROOT + "/public/images/frame_#{self.id}.png"
  end
  
  def colors
    [self.light, self.dark, self.accent, self.trim]
  end
  
  def after_create
    img = Magick::Image.new(120, 120) { self.background_color = "transparent" }
    frame = Magick::Draw.new
    frame.fill = "transparent"
    frame.stroke = "##{self.trim}"
    frame.stroke_width = 4
    frame.roundrectangle(2,2,117,117,12,12)
    frame.draw(img)
    img.matte = true
    img.write frame_filename
  end
  
  def before_destroy
    File.delete frame_filename
  end
  
  def self.random
    self.find(:all)[rand(self.count)]
  end
  
end
