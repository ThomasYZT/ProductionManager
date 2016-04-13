class Version < ActiveRecord::Base
  validates :version_code, presence: true
  validates :version_number, numericality: { only_integer: true }
end
