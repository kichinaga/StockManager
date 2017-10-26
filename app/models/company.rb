class Company < ApplicationRecord
  belongs_to :industry
  belongs_to :market
  has_one :stock_detail
end
