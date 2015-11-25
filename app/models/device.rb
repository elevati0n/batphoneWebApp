class Device < ActiveRecord::Base
  belongs_to :network
  validates :network_id, presence: true
  default_scope -> { order(created_at: :desc) }
  geocoded_by :address
  after_validation :geocode
   
def change
    create_table :devices do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.timestamps
    end
  end 
end
