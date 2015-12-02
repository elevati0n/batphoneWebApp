class Device < ActiveRecord::Base
  belongs_to :network
  validates :network_id, presence: true
  default_scope -> { order(created_at: :desc) }



end
