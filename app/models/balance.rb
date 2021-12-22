class Balance < ApplicationRecord
  validates :payer, uniqueness: true

  def self.by_payer(payer)
    where(payer: payer).first
  end
end
