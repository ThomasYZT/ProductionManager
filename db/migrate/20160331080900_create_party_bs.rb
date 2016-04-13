class CreatePartyBs < ActiveRecord::Migration
  def change
    create_table :party_bs do |t|
      t.string :name
      t.string :uuid
      t.string :phone
      t.string :card_number
      t.string :address

      t.timestamps null: false
    end
  end
end
