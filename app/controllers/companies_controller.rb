require 'open-uri'

class CompaniesController < ApplicationController

  def index
    @companies = Company.page(params[:page])
  end

  def search
    @par = search_params

    @companies = searchCompany(search_params)

    render action: :index
  end

  def show
    @company = Company.find_by(id: params[:id])
    @url = "https://stocks.finance.yahoo.co.jp/stocks/detail/?code=#{@company.stock_code}"

    ### Yahooファイナンスページをスクレイピング
    @res = parseHtml@url

    # binding.pry
  end


  private
  def parseHtml(url)
    ## html取得
    charset = nil
    html = open(url) do |f|
      charset = f.charset # 文字種別を取得
      f.read # htmlを読み込んで変数htmlに渡す
    end
    doc = Nokogiri::HTML.parse(html, charset).css('div#main')

    res = Hash.new

    ## スクレイピング
    stock_info = doc.css('div#stockinf > div.stocksDtl > div.forAddPortfolio')
    stock_detail = doc.at_css('div.chartFinance').css('div.innerDate > div.lineFi')

    res[:genre] = stock_info.css('dl > dd.category > a').inner_text # 業種
    res[:time] = stock_info.css('dl > dd.real > span').inner_text # リアルタイム計測の時間
    ## @res[:change] = stock_info.css('table.stocksTable > tbody > tr > td.change > span.yjMSt').inner_text # 前日比
    res[:price] = stock_info.css('table').css('td.stoksPrice')[1].inner_text # 現在の株価

    # 前日終値
    res[:prev_close] = stock_detail[0].css('dl > dd > strong').inner_text
    res[:prev_close_date] = stock_detail[0].css('dl > dd > span').inner_text
    # 始値
    res[:open] = stock_detail[1].css('dl > dd > strong').inner_text
    res[:open_date] = stock_detail[1].css('dl > dd > span.date').inner_text
    # 高値
    res[:high] = stock_detail[2].css('dl > dd > strong').inner_text
    res[:high_date] = stock_detail[2].css('dl > dd > span.date').inner_text
    # 安値
    res[:low] = stock_detail[3].css('dl > dd > strong').inner_text
    res[:low_date] = stock_detail[3].css('dl > dd > span.date').inner_text
    # 出来高
    res[:volume] = stock_detail[4].css('dl > dd > strong').inner_text
    res[:volume_date] = stock_detail[4].css('dl > dd > span.date').inner_text
    # 売買代金
    res[:total_trade] = stock_detail[5].css('dl > dd > strong').inner_text
    res[:total_trade_date] = stock_detail[5].css('dl > dd > span.date').inner_text
    # 値幅制限
    res[:price_limit] = stock_detail[6].css('dl > dd > strong').inner_text
    res[:price_limit_date] = stock_detail[6].css('dl > dd > span.date').inner_text

    res
  end

  # searchページの検索条件を指定（ゴリ押し）
  def searchCompany(search)
    if search[:market_id] != ''
      if search[:industry_id] != ''
        if search[:company_name] != ''
          return Company.where(market_id: search[:market_id]).where(industry_id: search[:industry_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
        else
          return Company.where(market_id: search[:market_id]).where(industry_id: search[:industry_id]).page(params[:page])
        end
      else
        if search[:company_name] != ''
          return Company.where(market_id: search[:market_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
        else
          return Company.where(market_id: search[:market_id]).page(params[:page])
        end
      end
    else
      if search[:industry_id] != ''
        if search[:company_name] != ''
          return Company.where(industry_id: search[:industry_id]).where('name like ?', "%#{search[:company_name]}%").page(params[:page])
        else
          return Company.where(industry_id: search[:industry_id]).page(params[:page])
        end
      else
        if search[:company_name] != ''
          return Company.where('name like ?', "%#{search[:company_name]}%").page(params[:page])
        else
          return Company.page(params[:page])
        end
      end
    end
  end

  def search_params
    params.require(:search).permit(:market_id, :industry_id, :company_name)
  end

end
