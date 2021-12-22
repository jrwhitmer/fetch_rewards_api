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
  end
end
