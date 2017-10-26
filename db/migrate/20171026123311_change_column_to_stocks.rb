class ChangeColumnToStocks < ActiveRecord::Migration[5.1]
  def change
    add_reference :stocks, :stock_list, foreign_key: true

    remove_reference :stocks, :user, foreign_key: true
    remove_reference :stocks, :company, foreign_key: true
  end
end
