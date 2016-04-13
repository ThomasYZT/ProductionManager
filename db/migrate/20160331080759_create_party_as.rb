class CreatePartyAs < ActiveRecord::Migration
  def change
    create_table :party_as do |t|
      t.string :city
      t.string :company

      t.timestamps null: false
    end
  end
end
