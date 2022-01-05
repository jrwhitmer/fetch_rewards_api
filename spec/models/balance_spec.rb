require 'rails_helper'
RSpec.describe Balance, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:payer) }
  end
  describe 'class methods' do
    it 'can return a balance record searching by payer' do
      fake_balance_1 = Balance.create!(payer: "DANNON", points: 500)
      fake_balance_2 = Balance.create!(payer: "MILLER COORS", points: 5000)
      fake_balance_3 = Balance.create!(payer: "UNILEVER", points: 100)

      expect(Balance.by_payer("DANNON")).to eq(fake_balance_1)
    end
    it 'can return the total points contained in all balances' do
      fake_balance_1 = Balance.create!(payer: "DANNON", points: 500)
      fake_balance_2 = Balance.create!(payer: "MILLER COORS", points: 5000)
      fake_balance_3 = Balance.create!(payer: "UNILEVER", points: 100)

      expect(Balance.total_points).to eq(5600)
    end
    it 'returns the balances in alphabetical order' do
      fake_balance_1 = Balance.create!(payer: "DANNON", points: 500)
      fake_balance_2 = Balance.create!(payer: "MILLER COORS", points: 5000)
      fake_balance_3 = Balance.create!(payer: "UNILEVER", points: 100)

      expect(Balance.alphabetical.first).to eq(fake_balance_1)
    end
  end
end
