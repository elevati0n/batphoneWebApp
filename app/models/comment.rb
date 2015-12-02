class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost

  validates :user, presence: true

  validates :text, presence: true, length: {minimum: 1, maximum: 140 }




end