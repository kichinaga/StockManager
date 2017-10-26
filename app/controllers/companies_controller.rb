require 'open-uri'

class CompaniesController < ApplicationController

  def index
    @companies = Company.page(params[:page])
  end

  def search
    @companies = searchCompany(search_params)
  end

  def show
    @company = Company.find_by(id: params[:id])
    Scraping::JPXScrape.set_capybara

    if @company.stock_detail.nil?
      scraper = Scraping::JPXScrape.new(@company.stock_code)
      @company = set_company_stock(@company.id, scraper.get_stock_details, false)
    else
      if @company.stock_detail.updated_at < 20.minutes.ago
        scraper = Scraping::JPXScrape.new(@company.stock_code)
        @company = set_company_stock(@company.id, scraper.get_stock_details, true)
      end
    end

    @detail = @company.stock_detail

    @url = "https://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{@company.stock_code}"
  end


  private
    def set_company_stock(id, data, flag)
      ## flag = true => 更新処理
      ##      = false => 作成処理
      if flag
        com = Company.find(id)
        com.stock_detail.update_attributes(price: data[:price],
                                            change: data[:change],
                                            prev_close_price: data[:prev_close],
                                            open_price: data[:open_price],
                                            high_price: data[:high_price],
                                            low_price: data[:low_price],
                                            volume: data[:volume],
                                            total_trade: data[:total_trade])

        com
      else
        detail = StockDetail.new(price: data[:price],
                                  change: data[:change],
                                  prev_close_price: data[:prev_close],
                                  open_price: data[:open_price],
                                  high_price: data[:high_price],
                                  low_price: data[:low_price],
                                  volume: data[:volume],
                                  total_trade: data[:total_trade])

        com = Company.find(id)
        com.stock_detail = detail
        com.save

        com
      end
    end

    # searchページの検索条件を指定（ゴリ押し）
    def searchCompany(search)
      if search[:stock_code] != ''
        Company.where(stock_code: search[:stock_code]).page(params[:page])
      else
        if search[:market_id] != ''
          if search[:industry_id] != ''
            if search[:company_name] != ''
              Company.where(market_id: search[:market_id]).where(industry_id: search[:industry_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
            else
              Company.where(market_id: search[:market_id]).where(industry_id: search[:industry_id]).page(params[:page])
            end
          else
            if search[:company_name] != ''
              Company.where(market_id: search[:market_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
            else
              Company.where(market_id: search[:market_id]).page(params[:page])
            end
          end
        else
          if search[:industry_id] != ''
            if search[:company_name] != ''
              Company.where(industry_id: search[:industry_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
            else
              Company.where(industry_id: search[:industry_id]).page(params[:page])
            end
          else
            if search[:company_name] != ''
              Company.where('name like ?', "%#{search[:company_name]}%").page(params[:page])
            else
              Company.page(params[:page])
            end
          end
        end
      end
    end

    def search_params
      params.require(:search).permit(:market_id, :industry_id, :company_name, :stock_code)
    end

end
