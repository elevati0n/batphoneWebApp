class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost
  before_create { self.id = rand(1000..9999)}

  validates :user, presence: true

  validates :text, presence: true, length: {minimum: 1, maximum: 140 }




end