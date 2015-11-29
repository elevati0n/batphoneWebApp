class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :member
      t.string :recording
      t.string :comment
      t.string :batphone
      t.string :profile

      t.timestamps null: false
    end
  end
end
