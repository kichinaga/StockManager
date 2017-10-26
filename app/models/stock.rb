class Stock < ApplicationRecord
  belongs_to :stock_list

  validates :num, presence: true
  validates :first_price, presence: true
end
