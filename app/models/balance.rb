class Balance < ApplicationRecord
  validates :payer, uniqueness: true 
end
