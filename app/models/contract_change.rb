class ContractChange < ActiveRecord::Base
  belongs_to :contract

  validates :contract_id, presence: true
  validates :contents,     presence: true
end
