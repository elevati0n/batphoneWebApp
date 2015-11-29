class AddNetworksToMicroposts < ActiveRecord::Migration
  def change
  	add_index :networks, :device
  end
end
