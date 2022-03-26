class PhotoGalleryUser < ApplicationRecord
  belongs_to :photo_gallery
  belongs_to :user
end
