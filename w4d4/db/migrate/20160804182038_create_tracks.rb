class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false, index: true
      t.boolean :bonus, default: false

      t.timestamps null: false
    end
  end
end
