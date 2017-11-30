class StockList < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :stocks, dependent: :destroy
  has_one :stock_total, dependent: :destroy, class_name: 'StockTotal'

  #新規作成した時に、activatedを有効化するように
  before_create -> { self.activated = true }

  # 全ての取引の結果(損益、保有株数)を集計し、更新する
  def trade_total
    price = 0
    amount = 0

    stocklist = stocks.sort_by{ |item| item.id }

    stocklist.each do |item|
      if 'buy' == item.action
        tmp = item.num
        price += item.price * tmp
        amount += tmp
      elsif 'sell' == item.action
        tmp = item.num
        price -= item.price * tmp
        amount -= tmp
      end
    end

    stock_total.update_attributes(price: price, amount: amount)
  end
end
