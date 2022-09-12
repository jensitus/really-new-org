class CreateDescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :descriptions do |t|
      t.text :text
      t.bigint :item_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
