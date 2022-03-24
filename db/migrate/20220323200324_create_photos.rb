class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :picture
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
  end
end
