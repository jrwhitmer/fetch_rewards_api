class Api::V1::BalancesController < ApplicationController

  def index
    balances = Balance.all
    render json: balances, each_serializer: BalanceSerializer, status: :ok
  end

  private

  def balance_params
    params.permit(:payer, :points)
  end
end
