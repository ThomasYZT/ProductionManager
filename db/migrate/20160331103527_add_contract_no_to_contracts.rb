class AddContractNoToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :contract_no, :string
  end
end
