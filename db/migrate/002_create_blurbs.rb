class CreateBlurbs < ActiveRecord::Migration
  def self.up
    create_table :blurbs do |t|
      t.column :title, :string
      t.column :body, :text
      t.column :project_id, :integer
      t.column :position, :integer
    end
  end

  def self.down
    drop_table :blurbs
  end
end
