class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :band_id, null: false, index: true
      t.boolean :live, default: false
      
      t.timestamps null: false
    end
  end
end
