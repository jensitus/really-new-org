class Photo < ApplicationRecord
  belongs_to :micropost
  mount_uploader :picture, PictureUploader
end
