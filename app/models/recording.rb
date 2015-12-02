class Recording < ActiveRecord::Base
  before_create { self.id = rand(1000..9999)}
  belongs_to :device
  belongs_to :network
  has_many :streams


end
