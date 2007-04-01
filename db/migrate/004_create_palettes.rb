class CreatePalettes < ActiveRecord::Migration
  def self.up
    create_table :palettes do |t|
      t.column :name, :string
      t.column :light, :string, :limit => 6
      t.column :dark, :string, :limit => 6
      t.column :accent, :string, :limit => 6
      t.column :trim, :string, :limit => 6
    end
  end

  def self.down
    drop_table :palettes
  end
end
