class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :network
  belongs_to :device
  has_many :comments, dependent: :destroy
  has_many :recordings
  has_one :stream
  before_create { self.id = rand(1000..9999)}

  validates :network_id, presence: true

  validates :device_id, presence: true


  validates :user_id, presence: true
  validates :content, presence: true, length: {minimum: 1, maximum: 140 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader


end
