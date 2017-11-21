class HomeController < ApplicationController
  def index
    if logged_in?
      @stock_lists = current_user.stock_lists.page(params[:page])
    end
  end
end
