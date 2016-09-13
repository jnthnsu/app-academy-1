class CreateTodoLists < ActiveRecord::Migration
  def change
    create_table :todo_lists do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
