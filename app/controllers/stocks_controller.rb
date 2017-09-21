class StocksController < ApplicationController
  # before_action :is_logined

  def show

  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    if @stock.save
      redirect_to user_path
    else
      render action: :new
    end
  end

  def edit
    @stock = Stock.find_by(id: params[:id])
  end

  def update
    @stock = Stock.find_by(id: params[:id])

    if @stock.update(stock_params)
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def destroy

  end

  private
  def stock_params
    params.require(:stock).permit(:num, :first_price, :user_id, :company_id)
  end
end
