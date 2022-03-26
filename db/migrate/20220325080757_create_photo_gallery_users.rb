class CreatePhotoGalleryUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_gallery_users do |t|
      t.belongs_to :user
      t.belongs_to :photo_gallery

      t.timestamps
    end
  end
end
