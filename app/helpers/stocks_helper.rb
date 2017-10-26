module StocksHelper


  def get_now_price(stock_code)
    Scraping::JPXScrape.set_capybara

    scraper = Scraping::JPXScrape.new(stock_code)

    scraper.get_now_price
  end
end
