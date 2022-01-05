require 'rails_helper'
RSpec.describe 'POST /api/v1/changelogs' do
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
    body = {
      "points": "5000"
    }

    patch '/api/v1/balances', params: body, as: :json

    expect(response).to have_http_status(200)
  end

  it 'returns a 400 status when the request is made incorrectly' do
    create_transactions
    body = {
    }

    patch '/api/v1/balances', params: body, as: :json

    expect(response).to have_http_status(400)
  end

  it 'returns an appropriate error message with a bad request' do
    create_transactions
    body = {
    }

    patch '/api/v1/balances', params: body, as: :json

    expect(response.body).to match(/Missing points/)
  end

  it 'returns the correct body with a good request' do
    create_transactions
    body = {
      "points": "5000"
    }

    patch '/api/v1/balances', params: body, as: :json

    balance_changelog = JSON.parse(response.body, symbolize_names: true)

    expect(balance_changelog).to eq([
      { payer: "DANNON", points: -100 },
      { payer: "UNILEVER", points: -200 },
      { payer: "MILLER COORS", points: -4700 }
      ])
  end

  it 'uses the oldest points gained first' do
    create_transactions
    @transaction_older = Transaction.create!(payer: "DANNON", points: 10000, timestamp: "2019-11-02T14:00:00Z")
    @balance_1 = Balance.update(points: 11000)

    body = {
      "points": "5000"
    }

    patch '/api/v1/balances', params: body, as: :json

    balance_changelog = JSON.parse(response.body, symbolize_names: true)

    expect(balance_changelog).to eq([{payer: "DANNON", points: -5000}])
  end

  it 'updates the balances with this request' do
    create_transactions
    body = {
      "points": "5000"
    }

    patch '/api/v1/balances', params: body, as: :json

    get '/api/v1/balances'

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[0][:payer]).to eq("UNILEVER")
    expect(response_body[1][:payer]).to eq("DANNON")
    expect(response_body[2][:payer]).to eq("MILLER COORS")

    expect(response_body[0][:points]).to eq(0)
    expect(response_body[1][:points]).to eq(1000)
    expect(response_body[2][:points]).to eq(5300)
  end

  it 'does not put any balance in the negative to complete this request' do
    @transaction_insufficient = Transaction.create!(payer: "DANNON", points: 1000, timestamp: "2019-11-02T14:00:00Z")
    @balance_4 = Balance.create!(payer: "DANNON", points: 1000)

    body = {
      "points": "5000"
    }

    patch '/api/v1/balances', params: body, as: :json

    expect(response.status).to eq(400)
    expect(JSON.parse(response.body)).to eq({"error"=>"Insufficient Points"})

  end

  xit 'returns an appropriate error message if the users balances do not have enough points to complete the spend request' do

  end
end
