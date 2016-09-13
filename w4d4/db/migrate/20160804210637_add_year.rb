class AddYear < ActiveRecord::Migration
  def change
    add_column :albums, :year, :integer, null: false
  end
end
