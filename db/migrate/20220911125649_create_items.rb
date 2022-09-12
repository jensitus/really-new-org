class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done, default: false
      t.bigint :todo_id
      t.bigint :created_by

      t.timestamps
    end
  end
end
