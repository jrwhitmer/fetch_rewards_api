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
  it 'returns a 400 status when the request is made incorrectly' do
    transaction_params = {
      payer: "DANNON",
      points: 500
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response).to have_http_status(400)
  end
  it 'returns an appropriate error message with the bad request' do
    bad_transaction_params_1 = {
      payer: "DANNON",
      points: 500
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(bad_transaction_params_1)

    expect(response.body).to match(/Missing timestamp parameter in request/)

    bad_transaction_params_2 = {
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(bad_transaction_params_2)

    expect(response.body).to match(/Missing payer parameter in request/)

    bad_transaction_params_3 = {
      payer: "DANNON",
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(bad_transaction_params_3)

    expect(response.body).to match(/Missing points parameter in request/)
  end
  it 'creates a new transaction object when the request is successful' do
    transaction_params = {
      payer: "DANNON",
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    transaction_created = Transaction.last
    expect(transaction_params[:payer]).to eq(transaction_created.payer)
    expect(transaction_params[:points]).to eq(transaction_created.points)
    expect(transaction_params[:timestamp]).to eq(transaction_created.timestamp.strftime('%Y-%m-%dT%H:%M:%SZ'))
  end
  it 'returns the correct response body when the request is successful' do
    transaction_params = {
      payer: "DANNON",
      points: 500,
      timestamp: "2020-11-02T14:00:00Z"
    }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/transactions', headers: headers, params: JSON.generate(transaction_params)

    expect(response.body).to match("{\"data\":{\"id\":\"#{Transaction.last.id}\",\"type\":\"transaction\",\"attributes\":{\"payer\":\"#{Transaction.last.payer}\",\"points\":#{Transaction.last.points},\"timestamp\":\"2020-11-02T14:00:00.000Z\"}}}")
  end
end
