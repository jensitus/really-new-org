class Photo < ApplicationRecord
  has_one :micropost
  mount_uploader :picture, PictureUploader
  has_many :comments
  has_one :photo_gallery
end
