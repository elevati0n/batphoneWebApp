class Device < ActiveRecord::Base
  belongs_to :network
  validates :network_id, presence: true
  default_scope -> { order(created_at: :desc) }
  before_create { self.id = rand(1000..9999)}
  has_many :streams



end
