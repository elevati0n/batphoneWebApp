class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :data
      t.string :time
      t.string :date
      t.string :owner
      t.string :recording

      t.timestamps null: false
    end
  end
end
