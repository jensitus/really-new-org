class AddMicropostIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :micropost_id, :bigint
  end
end
