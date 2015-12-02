class Network < ActiveRecord::Base
  enum audience: [ :restricted, :open ]

  validates :name,  presence: true, length: { maximum: 50 }

  validates :publickey, presence:true, :unless => '!private?'

  has_many :devices, dependent: :destroy

  has_many :microposts, dependent: :destroy
  has_many :users
  belongs_to :admin, :class_name => 'User'
  before_create { self.id = rand(1000..9999)}
  has_many :streams

  enum key_type:  [:rsa, :dsa, :ecdsa, :drop_bear]



end
