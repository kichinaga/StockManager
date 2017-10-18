module CompaniesHelper
  BASE_URL = 'https://www.nikkei.com/search/site/'

  def get_news_list(stock_code)
    Scraping::NewsScrape.set_capybara(BASE_URL)

    scraper = Scraping::NewsScrape.new(stock_code)

    scraper.get_news_link
  end
end
