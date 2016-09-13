class GoalDelete < ActiveRecord::Migration
  def change
    drop_table :goals

    create_table :goals do |t|
      t.integer :user_id, null: false, index: true
      t.string :title, null: false
      t.text :details, null: false
      t.boolean :private, default: false
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end
end
