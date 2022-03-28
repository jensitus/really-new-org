class Comment < ApplicationRecord
  has_one :micropost
  has_one :photo
  validates_presence_of :body
  belongs_to :user
end
