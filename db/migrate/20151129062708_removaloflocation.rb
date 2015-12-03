class Removaloflocation < ActiveRecord::Migration
 def up
 remove_column :devices, :location, :text_area
 end
 def down
 add_column :devices, :location, :text_area
 end
end
