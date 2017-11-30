class StockListsController < ApplicationController
  before_action :is_user_logged

  def index
    @stock_lists = StockList.where(user_id:session[:user_id])
  end

  def show
    @stock_list = StockList.find_by(id: params[:id])
    @stocks = @stock_list.stocks.page(params[:page])
    @results = @stock_list.stock_total
    @company = @stock_list.company

    @stock = Stock.new
    @now_price = @company.stock_detail.price.match(/(.*)(?=\()/)[1].gsub(',', '').strip.to_i
  end

  def create
    @stock_list = StockList.new(stock_list_params)

    if @stock_list.save
      # 全体の結果を管理するstockモデルを生成
      StockTotal.create(price: 0, amount: 0, stock_list_id: @stock_list.id)

      flash[:notice] = '登録が完了しました'
      redirect_to root_url
    else
      ## 失敗した時
      flash[:notice] = '登録に失敗しました'
      redirect_to controller: :companies, action: :show, id: stock_list_params[:company_id]
    end
  end

  private
    def stock_list_params
      params.require(:stock_list).permit(:user_id, :company_id)
    end
end
