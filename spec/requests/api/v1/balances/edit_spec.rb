require 'rails_helper'
RSpec.describe 'PATCH /api/v1/balances' do
  let :create_transactions do
    @transaction_1 = Transaction.create!(payer: "DANNON", points: 1000, timestamp: "2020-11-02T14:00:00Z")
    @transaction_2 = Transaction.create!(payer: "UNILEVER", points: 200, timestamp: "2020-10-31T11:00:00Z")
    @transaction_3 = Transaction.create!(payer: "DANNON", points: -200, timestamp: "2020-10-31T15:00:00Z" )
    @transaction_4 = Transaction.create!(payer: "MILLER COORS", points: 10000, timestamp: "2020-11-01T14:00:00Z" )
    @transaction_5 = Transaction.create!(payer: "DANNON", points: 300, timestamp: "2020-10-31T10:00:00Z")
    @balance_1 = Balance.create!(payer: "DANNON", points: 1100)
    @balance_2 = Balance.create!(payer: "UNILEVER", points: 200)
    @balance_3 = Balance.create!(payer: "MILLER COORS", points: 10000)
  end
  it 'returns a 200 status when the request is made correctly' do
    create_transactions
    balance_params = {
      points: 5000
    }

    patch '/api/v1/balances', headers: headers, params: balance_params

    expect(response).to have_http_status(200)
  end

  it 'returns a 400 status when the request is made incorrectly' do
    points_body = {
    }

    patch '/api/v1/balances', headers: headers, params: points_body

    expect(response).to have_http_status(400)
  end

  it 'returns an appropriate error message with a bad request' do
    points_body = {
    }

    patch '/api/v1/balances', headers: headers, params: points_body

    expect(response.body).to match(/Missing points/)
  end

  it 'returns the correct body with a good request' do
    points_body = {
      points: 5000
    }

    patch '/api/v1/balances', headers: headers, params: points_body

    balance_changelog = JSON.parse(response.body, symbolize_names: true)

    expect(balance_changelog).to eq([
      { payer: "DANNON", points: -100 },
      { payer: "UNILEVER", points: -200 },
      { payer: "MILLER COORS", points: -4700 }
      ])
  end

  xit 'uses the oldest points gained first' do

  end

  xit 'updates the balances with this request' do

  end

  xit 'does not put any balance in the negative to complete this request' do

  end

  xit 'returns an appropriate error message if the users balances do not have enough points to complete the spend request' do

  end
end
