class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :simple
      t.boolean :done, default: false
      t.integer :created_by

      t.timestamps
    end
  end
end
