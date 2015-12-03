class AddStrengthToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :strength, :integer
  end
end
