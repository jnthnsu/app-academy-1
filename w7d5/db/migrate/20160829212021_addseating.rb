class Addseating < ActiveRecord::Migration
  def change
    add_column :benches, :seating, :integer, default: 4
  end
end
