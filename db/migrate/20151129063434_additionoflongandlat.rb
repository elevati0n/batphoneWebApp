class Additionoflongandlat < ActiveRecord::Migration
  def up
  add_column :devices, :latitude, :string
  end
  def down 
  remove_column :devices, :latitude, :string
  end
end
