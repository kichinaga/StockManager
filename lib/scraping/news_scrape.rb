require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module Scraping
  class NewsScrape
    include Capybara::DSL
    CHARSET = 'utf-8'

    def initialize(stock_code)
      @url = "https://www.nikkei.com/search/site/?searchKeyword=#{stock_code}"
      @stock_code = stock_code
      @articles = Array.new
      open_page
    end

    def get_news_link
      wait_for_ajax
      find('app-result').all('article').each do |article|
        link = article.find('a')
        @articles.push({stock_code: @stock_code,
                        title: link.find('h3').text,
                        url: link[:href],
                        date: Time.parse(link.find('.status').text[/（(.*?)）/, 1])
                       })
      end
      @articles
    end

    def self.set_capybara(url)
      Capybara.configure do |config|
        config.run_server = false
        config.current_driver = :poltergeist
        config.javascript_driver = :poltergeist
        config.ignore_hidden_elements = true
        config.app_host = url
        config.default_max_wait_time = 5
      end

      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(
            app, { timeout: 120, js_errors: false, phantomjs_options: %w(--load-images=no --ignore-ssl-errors=no --ssl-protocol=any) }
        )
      end
    end

    private
      def wait_for_ajax
        until find('app-result')
        end
      end

      def open_page
        visit @url
      end
  end
end