class AddRecordingToMicropost < ActiveRecord::Migration
  def change
    add_reference :microposts, :recording, index: true, foreign_key: true
  end
end
