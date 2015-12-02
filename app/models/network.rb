class Network < ActiveRecord::Base
  validates :name,  presence: true, length: { maximum: 50 }
  validates :publickey, presence:true
  has_many :devices, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :users
  belongs_to :admin, :class_name => 'User'
  before_create { self.id = rand(1000..9999)}
  has_many :streams



end
