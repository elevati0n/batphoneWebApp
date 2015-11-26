class AddNetworksAndDevicesAndIndexToMicroposts < ActiveRecord::Migration
  def change
    add_reference :microposts, :device, index: true, foreign_key: true
    add_reference :microposts, :network, index: true, foreign_key: true
    add_column :microposts, :private, :boolean
  end
end
