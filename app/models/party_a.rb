class PartyA < ActiveRecord::Base
  has_many :contracts
  has_many :party_bs, through: :contracts

  validates :city, presence: true , on: :create
  validates :company, presence: true, on: :create

  
end
