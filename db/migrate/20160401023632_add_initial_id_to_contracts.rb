class AddInitialIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :initial_id, :integer
  end
end
