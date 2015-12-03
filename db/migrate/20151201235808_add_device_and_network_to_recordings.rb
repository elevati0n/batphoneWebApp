class AddDeviceAndNetworkToRecordings < ActiveRecord::Migration
  def change
    add_reference :recordings, :device, index: true, foreign_key: true
    add_reference :recordings, :network, index: true, foreign_key: true
  end
end
