require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

module Scraping
  class NewsScrape
    include Capybara::DSL
    CHARSET = 'utf-8'

    def initialize(stock_code)
      # @url = "https://www.nikkei.com/search/site/?searchKeyword=#{stock_code}"
      @url = "https://www.nikkei.com/nkd/company/news/?scode=#{stock_code}"
      @stock_code = stock_code
      @articles = Array.new
      open_page
    end

=begin
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
=end

    def get_news_link
      doc = Nokogiri::HTML.parse(html)
      doc.css('div.m-listFormat').each do |div|
        div.css('li').each do |item|
          if item.css('span.m-listItem_text_text').inner_text == '表示できる情報はありません。'
            @articles.push({
                               stock_code: @stock_code,
                               title: '表示できる情報はありません。',
                               url: '',
                               date: ''
                           })
          else
            @articles.push({
                               stock_code: @stock_code,
                               title: item.css('a').inner_text,
                               url: "https://www.nikkei.com#{item.css('a')[0][:href]}",
                               date: item.css('span.m-listItem_time').inner_text
                           })
          end
        end
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
        # find('div.pageNav_body').click_link('ニュース')
      end
  end
end