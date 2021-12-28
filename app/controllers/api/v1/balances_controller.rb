class Api::V1::BalancesController < ApplicationController

  def index
    balances = Balance.all
    if balances.length > 0
      render json: balances, each_serializer: BalanceSerializer, status: :ok
    else
      render_unprocessable_entity("No balances found")
    end
  end

  def edit
    transactions = Transaction.oldest_to_newest
    
  end

  private

  def balance_params
    params.permit(:payer, :points)
  end
end
