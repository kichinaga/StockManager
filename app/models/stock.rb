class Stock < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :num, presence: true
  validates :first_price, presence: true
end
