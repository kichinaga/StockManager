class StockList < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :stocks
end
