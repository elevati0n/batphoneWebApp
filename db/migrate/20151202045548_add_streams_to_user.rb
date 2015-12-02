class AddStreamsToUser < ActiveRecord::Migration
  def change
    add_reference :users, :stream, index: true, foreign_key: true
  end
end
