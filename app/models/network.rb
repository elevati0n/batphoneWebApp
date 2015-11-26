class Network < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  validates :publickey, presence:true
  has_many :devices, dependent: :destroy
  has_many :microposts, dependent: :destroy



end
