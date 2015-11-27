class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :IP_address
      t.string :MAC
      t.string :AP_SSID
      t.string :Gateway_mode
      t.text :description
      t.text :location
      t.text :notes
      t.references :network, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
