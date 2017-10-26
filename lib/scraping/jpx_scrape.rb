require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module Scraping
  class JPXScrape
    include Capybara::DSL

    attr_accessor :doc
    CHARSET = 'utf-8'
    BASE_URL = 'http://quote.jpx.co.jp/jpx/template/quote.cgi?F=tmp/stock_search'

    def initialize(stock_code)
      @url = 'http://quote.jpx.co.jp/jpx/template/quote.cgi?F=tmp/stock_search'
      @stock_code = stock_code
      access_company_page
    end

    def get_stock_details
      res = {}
      res[:price] = get_now_price
      res[:change] = get_change
      res[:prev_close] = get_prev_close_price
      res[:open_price] = get_open_price
      res[:high_price] = get_high_price
      res[:low_price] = get_low_price
      res[:volume] = get_volume
      res[:total_trade] = get_total_trade

      res
    end

    # 現在値(時刻)
    def get_now_price
      get_table_element 0, 1
    end

    def self.set_capybara()
      Capybara.configure do |config|
        config.run_server = false
        config.current_driver = :poltergeist
        config.javascript_driver = :poltergeist
        config.ignore_hidden_elements = true
        config.app_host = BASE_URL
        config.default_max_wait_time = 5
      end

      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(
            app, { timeout: 120, js_errors: false, phantomjs_options: %w(--load-images=no --ignore-ssl-errors=no --ssl-protocol=any) }
        )
      end
    end

    private
      def open_page(link = '')
        visit link
      end

      def click_search
        fill_in 'KEY5', with: @stock_code
        click_button('検索開始')
      end

      def click_company
        find(:xpath, "//a[@class='lst']").click
      end

      def access_company_page
        open_page(@url)

        click_search

        click_company

        self.doc = Nokogiri::HTML.parse(html, nil, CHARSET)
                       .xpath('/html/body/table')[1]
                       .xpath('tbody/tr/td')[1]
                       .xpath('table')[1]
                       .xpath('tbody/tr')[3]
                       .xpath('td/table')[1]
                       .xpath('tbody/tr')
      end

      # 前日比(%)
      def get_change
        get_table_element 0, 3
      end

      # 前日終値
      def get_prev_close_price
        get_table_element 2, 3
      end

      # 始値
      def get_open_price
        get_table_element 2, 1
      end

      # 高値
      def get_high_price
        get_table_element 3, 1
      end

      # 安値
      def get_low_price
        get_table_element 3, 3
      end

      # 出来高
      def get_volume
        get_table_element 5, 1
      end

      # 売買代金
      def get_total_trade
        get_table_element 5, 3
      end

      def get_table_element(row, col)
        doc[row].css('td')[col].inner_text
      end
  end
end
