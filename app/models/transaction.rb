class Transaction < ApplicationRecord

  def self.oldest_to_newest
    order(:timestamp)
  end
end
