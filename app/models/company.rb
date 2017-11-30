class Company < ApplicationRecord
  belongs_to :industry
  belongs_to :market
  has_one :stock_detail, dependent: :destroy, class_name: 'StockDetail'
end
