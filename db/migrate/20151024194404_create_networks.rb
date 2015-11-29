class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.text :publickey

      t.timestamps null: false
    end
  end
end
