class AddAudienceToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :private, :boolean
  end
end
