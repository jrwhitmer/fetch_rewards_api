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
    if params[:points].nil?
      render_bad_request("Missing points")
    else
      transactions = Transaction.oldest_to_newest
      @original_balances = []
      Balance.all.each do |balance|
        original_balance = {payer: balance.payer, points: balance.points}
        @original_balances << original_balance
      end
      @points_counter = params[:points].to_i
      @changes = []
      transactions.each do |transaction|
        current_balance = Balance.by_payer(transaction.payer)
        if transaction.points >= @points_counter && @points_counter > 0
          if current_balance.points >= transaction.points
            new_points = current_balance.points - @points_counter
            current_balance.update(points: new_points)
            @points_counter = 0
          else
            if current_balance.points > 0
              @points_counter -= current_balance.points
              current_balance.update(points: 0)
            end
          end
        elsif transaction.points < @points_counter && @points_counter > 0
          current_balance = Balance.by_payer(transaction.payer)
          if current_balance.points >= transaction.points
            new_points = current_balance.points - transaction.points
            current_balance.update(points: new_points)
            @points_counter -= transaction.points
          elsif current_balance.points > 0
            @points_counter -= current_balance.points
            current_balance.update(points: 0)
          end
        end
      end
      @return_array = []
      @original_balances.each do |original_balance|
        updated_balance = Balance.by_payer(original_balance[:payer])
        total_change = (updated_balance.points - original_balance[:points])
        change = {payer: updated_balance.payer, points: total_change}
        @return_array << change
      end
      changelogs = []
      @return_array.each do |element|
        new_changelog = Changelog.new(element[:payer], element[:points])
        changelogs << new_changelog
      end
      render json: changelogs, each_serializer: ChangelogSerializer, status: :ok
    end
  end

  private

  def balance_params
    params.permit(:points)
  end
end
