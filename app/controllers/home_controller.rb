class HomeController < ApplicationController
  def index
    if logged_in?
      @stocks = current_user.stocks.page(params[:page])
    end
  end
end
