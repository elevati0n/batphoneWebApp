class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :originator
      t.string :time
      t.string :date
      t.string :URI

      t.timestamps null: false
    end
  end
end
