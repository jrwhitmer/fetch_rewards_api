class Api::V1::TransactionsController < ApplicationController
  def create
    if !params[:payer].present?
      render_bad_request("Missing payer parameter in request")
    elsif !params[:points].present?
      render_bad_request("Missing points parameter in request")
    elsif !params[:timestamp].present?
      render_bad_request("Missing timestamp parameter in request")
    else
      transaction = Transaction.create!(transaction_params)
      json_response(TransactionSerializer.new(transaction), :created)
    end 
  end

  private

  def transaction_params
    params.permit(:payer, :points, :timestamp)
  end
end
