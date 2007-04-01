class AddBodyToProjects < ActiveRecord::Migration
  def self.up
    alter_table :projects do |t|
      t.column :body, :text
    end
  end

  def self.down
    drop_column :projects, :body
  end
end
