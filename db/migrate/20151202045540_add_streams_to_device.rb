class AddStreamsToDevice < ActiveRecord::Migration
  def change
    add_reference :devices, :stream, index: true, foreign_key: true
  end
end
