class StocksController < ApplicationController
  before_action :is_user_logged


  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to controller: :stock_lists, action: :show, id: @stock.stock_list.id
    else
      flash[:notice] = '登録が失敗しました'
      redirect_to root_url
    end
  end


  def destroy

  end

  private
  def stock_params
    params.require(:stock).permit(:num, :price, :action, :stock_list_id)
  end
end
