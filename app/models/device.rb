class Device < ActiveRecord::Base
  belongs_to :network
  validates :network_id, presence: true
  default_scope -> { order(created_at: :desc) }
  before_create { self.id = rand(1000..9999)}
  has_many :streams
  #before_save {self.IP_address = IPAddr.new(self.IP_address).to_i}

  #after_find {self.IP_address = IPAddr.new(self.IP_address).to_s}




end
