class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :breed
      t.string :cultivated_area
      t.string :transplant_number
      t.string :purchase
      t.integer :party_a_id
      t.integer :party_b_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
