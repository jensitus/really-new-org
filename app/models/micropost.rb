class Micropost < ApplicationRecord
  has_many :photos
  accepts_nested_attributes_for :photos
  belongs_to :user
end
