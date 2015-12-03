class AddMicropostsToStreams < ActiveRecord::Migration
  def change
    add_reference :streams, :microposts, index: true, foreign_key: true
  end
end
