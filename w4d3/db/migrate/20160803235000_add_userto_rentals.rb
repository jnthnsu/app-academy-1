class AddUsertoRentals < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, index: true
    change_column :cat_rental_requests, :user_id, :integer, null: false 
  end
end
