class PartyB < ActiveRecord::Base
  has_many :contracts
  has_many :party_as, through: :contracts

  validates :name, presence: true, on: :create
  validates :uuid, presence: true, on: :create
  validates :card_number, presence: true, on: :create
  validates :address, presence: true, on: :create
  validates :phone, presence: true, on: :create
  validates :bank, presence: true, on: :create
end
