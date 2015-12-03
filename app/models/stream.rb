class Stream < ActiveRecord::Base
  belongs_to :device
  belongs_to :user
  belongs_to :network
end
