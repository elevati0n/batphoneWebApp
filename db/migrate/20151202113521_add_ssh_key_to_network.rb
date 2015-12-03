class AddSshKeyToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :ssh_key, :text
  end
end
