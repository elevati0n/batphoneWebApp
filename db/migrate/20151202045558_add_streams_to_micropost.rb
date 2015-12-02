class AddStreamsToMicropost < ActiveRecord::Migration
  def change
    add_reference :microposts, :stream, index: true, foreign_key: true
  end
end
