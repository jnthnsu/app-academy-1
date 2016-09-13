class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.text :body, null: false
      t.integer :todo_list_id, null: false, index: true
      t.boolean :completed, default: false
      t.timestamps null: false
    end
  end
end
