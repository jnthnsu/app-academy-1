class Updatecomment < ActiveRecord::Migration
  def change
    drop_table :comments
    create_table :comments do |t|
      t.integer :user_id, null: false, index: true
      t.references :commentable, null: false, polymorphic: true, index: true
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
