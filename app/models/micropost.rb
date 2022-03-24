class Micropost < ApplicationRecord
  has_many :photos
  has_many :comments
  accepts_nested_attributes_for :photos
  belongs_to :user
end
