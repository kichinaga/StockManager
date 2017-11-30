class Stock < ApplicationRecord
  belongs_to :stock_list

  default_scope -> { order(created_at: :desc) }

  validates :num, presence: true
  validates :price, presence: true
end
