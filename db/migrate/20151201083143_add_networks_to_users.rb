class AddNetworksToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :network, index: true, foreign_key: true
  end
end
