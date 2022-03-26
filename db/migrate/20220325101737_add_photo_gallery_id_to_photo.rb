class AddPhotoGalleryIdToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :photo_gallery_id, :bigint
  end
end
