class Devices < ActiveRecord::Migration
  def up
  add_column :devices, :longitude, :string
  end
  def down
  remove_column :devices, :longitude, :string
  end
end
