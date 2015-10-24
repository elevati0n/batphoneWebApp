class Network < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  validates :publickey, presence:true
end
