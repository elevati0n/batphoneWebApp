class AddUsersToNetwork < ActiveRecord::Migration
  def change
    add_reference :networks, :user, index: true, foreign_key: true
    add_reference :networks, :admin, index: true, foreign_key: true
  end
end
