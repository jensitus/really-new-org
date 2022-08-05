class PhotoGallery < ApplicationRecord
  has_many :photo_gallery_users
  has_many :users, through: :photo_gallery_users
  has_many :photos

  def get_titles
    
  end

end

