# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# coding: utf-8
require 'csv'


### Market
market = Hash.new
CSV.foreach('db/csv/market.csv') do |row|
  ## ハッシュに格納
  market.store row[1], row[0]
  Market.create(name: row[1])
end

### Industry
industry = Hash.new
CSV.foreach('db/csv/industry.csv') do |row|
  industry.store row[1], row[0]
  Industry.create(name: row[1])
end

### Company
company = ['tosyo1.csv', 'tosyo2.csv','tosyom.csv', 'jasdaq.csv', 'other.csv']
company.each do |filename|
  CSV.foreach("db/csv/#{filename}") do |row|
    Company.create(stock_code: row[0],
                   name: row[1],
                   market_id: market[row[2]],
                   industry_id: industry[row[3]]
    )
  end
end