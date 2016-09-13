class AddEmailField < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    change_column :users, :email, :string, :null => false
  end
end
