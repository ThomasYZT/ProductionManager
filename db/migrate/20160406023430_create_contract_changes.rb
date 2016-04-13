class CreateContractChanges < ActiveRecord::Migration
  def change
    create_table :contract_changes do |t|
      t.integer :contract_id
      t.string :content

      t.timestamps null: false
    end
  end
end
