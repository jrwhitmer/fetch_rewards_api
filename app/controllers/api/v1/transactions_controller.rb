class Api::V1::TransactionsController < ApplicationController
  def create
    transaction = Transaction.create!(transaction_params)
    json_response(TransactionSerializer.new(transaction), :created)
  end

  private

  def transaction_params
    params.permit(:payer, :points, :timestamp)
  end
end
