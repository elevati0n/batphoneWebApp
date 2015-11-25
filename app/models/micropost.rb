class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :network
  belongs_to :device
  has_many :comments, dependent: :destroy


  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader


end
