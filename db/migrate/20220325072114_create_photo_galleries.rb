class CreatePhotoGalleries < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_galleries do |t|
      t.string :title
      t.text :description
      t.bigint :last_updated_by_id

      t.timestamps
    end
  end
end
