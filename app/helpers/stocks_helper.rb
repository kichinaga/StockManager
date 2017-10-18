module StocksHelper
  BASE_URL = 'http://quote.jpx.co.jp/jpx/template/quote.cgi?F=tmp/stock_search'

  def get_now_price(stock_code)
    Scraping::JPXScrape.set_capybara(BASE_URL)

    scraper = Scraping::JPXScrape.new(stock_code)

    scraper.get_now_price
  end
end
