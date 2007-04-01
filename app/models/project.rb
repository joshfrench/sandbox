class Project < ActiveRecord::Base
  has_many :blurbs, :order => :position
  validates_presence_of :name
  has_one :image, :foreign_key => :belongsto_id, :dependent => :destroy
  
  def before_update
    self.slug = self.name.gsub(/[^A-Za-z0-9\s\-_]/, '').squeeze(' ').gsub(/\s/, '-').downcase
  end
end
