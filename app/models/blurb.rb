class Blurb < ActiveRecord::Base
  belongs_to :project
  has_one :image, :foreign_key => :belongsto_id, :dependent => :destroy
  acts_as_list :scope => :project_id
end
