require 'rails_helper'
RSpec.describe 'POST /api/v1/transactions' do
  it 'returns a 201 status when the request is made correctly' do
    transaction_params = {
      payer: "DANNON",
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response).to have_http_status(201)
  end
  xit 'returns a 400 status when the request is made incorrectly' do
    transaction_params = {
      payer: "DANNON",
      points: 500
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response).to have_http_status(400)
  end
  xit 'returns an appropriate error message with the bad request' do
    transaction_params = {
      payer: "DANNON",
      points: 500
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response.body).to match(/Missing a parameter in request/)
  end
  xit 'creates a new transaction object when the request is successful' do
    transaction_params = {
      payer: "DANNON",
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    transaction_created = Transaction.last
    expect(transaction_params.payer).to eq(transaction_created.payer)
    expect(transaction_params.points).to eq(transaction_created.points)
    expect(transaction_params.timestamp).to eq(transaction_created.timestamp)
  end
  xit 'returns the correct response body when the request is successful' do
    transaction_params = {
      payer: "DANNON",
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response.body).to match(/Transaction created!/)
  end
end
