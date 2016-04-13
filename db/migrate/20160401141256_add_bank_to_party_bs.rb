class AddBankToPartyBs < ActiveRecord::Migration
  def change
    add_column :party_bs, :bank, :string
  end
end
