require 'rails_helper'
RSpec.describe 'GET /api/v1/balances' do
  before :each do
    @fake_balance_1 = Balance.create!(payer: "DANNON", points: 500)
    @fake_balance_2 = Balance.create!(payer: "MILLER COORS", points: 5000)
    @fake_balance_3 = Balance.create!(payer: "UNILEVER", points: 100)
  end
  it 'returns a 200 status when the request is made correctly' do
    get '/api/v1/balances'

    expect(response).to have_http_status(200)
  end
  it 'returns the correct body when request is successful' do
    get '/api/v1/balances'

    balances = JSON.parse(response.body, symbolize_names: true)

    expect(balances[0][:payer]).to eq("DANNON")
    expect(balances[1][:payer]).to eq("MILLER COORS")
    expect(balances[2][:payer]).to eq("UNILEVER")

    expect(balances[0][:points]).to eq(500)
    expect(balances[1][:points]).to eq(5000)
    expect(balances[2][:points]).to eq(100)

    expect(balances.length).to eq(3)
  end
end
