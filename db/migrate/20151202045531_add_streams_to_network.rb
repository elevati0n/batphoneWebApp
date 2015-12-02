class AddStreamsToNetwork < ActiveRecord::Migration
  def change
    add_reference :networks, :stream, index: true, foreign_key: true
  end
end
