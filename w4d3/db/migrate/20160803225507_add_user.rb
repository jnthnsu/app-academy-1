class AddUser < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, index: true
    change_column :cats, :user_id, :integer, null: false
  end
end
