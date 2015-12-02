class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :port
      t.references :device, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :network, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
