class Balance < ApplicationRecord
  validates :payer, uniqueness: true

  def self.by_payer(payer)
    where(payer: payer).first
  end

  def self.total_points
    sum(:points)
  end

  def self.alphabetical
    order(:payer)
  end
end
