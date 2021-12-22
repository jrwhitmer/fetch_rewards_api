class Api::V1::TransactionsController < ApplicationController
  def create
    if !params[:payer].present?
      render_bad_request("Missing payer parameter in request")
    elsif !params[:points].present?
      render_bad_request("Missing points parameter in request")
    elsif !params[:timestamp].present?
      render_bad_request("Missing timestamp parameter in request")
    else
      exisiting_balance = Balance.by_payer(params[:payer])
      if exisiting_balance.nil? && params[:points] > 0
        transaction = Transaction.create!(transaction_params)
        json_response(TransactionSerializer.new(transaction), :created)
        Balance.create!(payer: params[:payer], points: params[:points])
      elsif exisiting_balance.nil? && params[:points] < 0
        render_bad_request("Cannot take points from an empty balance")
      elsif !exisiting_balance.nil? && params[:points] < 0
        if exisiting_balance.points > params[:points].abs
          new_points_total = exisiting_balance.points + params[:points]
          transaction = Transaction.create!(transaction_params)
          json_response(TransactionSerializer.new(transaction), :created)
          Balance.update(points: new_points_total)
        else
          render_bad_request("Not enough points with this payer to complete transaction")
        end
      elsif !exisiting_balance.nil? && params[:points] > 0
        new_points_total = exisiting_balance.points + params[:points]
        transaction = Transaction.create!(transaction_params)
        json_response(TransactionSerializer.new(transaction), :created)
        Balance.update(points: new_points_total)
      end
    end
  end

  private

  def transaction_params
    params.permit(:payer, :points, :timestamp)
  end
end
