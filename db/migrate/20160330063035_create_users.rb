class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userid
      t.string :username
      t.string :hashed_password
      t.string :role
      t.integer :station_id

      t.timestamps null: false
    end
  end
end
