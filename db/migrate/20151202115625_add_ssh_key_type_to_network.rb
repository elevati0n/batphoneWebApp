class AddSshKeyTypeToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :key_type, :integer
  end
end
