require 'rails_helper'
RSpec.describe Transaction, type: :model do
  describe 'class methods' do
    it '#oldest_to_newest' do
      @transaction_1 = Transaction.create!(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
      @transaction_2 = Transaction.create!(payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z")
      @transaction_3 = Transaction.create!(payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z" )
      @transaction_4 = Transaction.create!(payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z" )
      @transaction_5 = Transaction.create!(payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z")

      expect(Transaction.oldest_to_newest.first).to eq(@transaction_5)
    end
  end
end
