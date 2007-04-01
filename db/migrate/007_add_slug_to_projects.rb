class AddSlugToProjects < ActiveRecord::Migration
  def self.up
    alter_table :projects do |t|
      t.column :slug, :string
    end
  end

  def self.down
    drop_column :projects, :slug
  end
end
