class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname, null: false
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.timestamps null: false
    end
  end
end
