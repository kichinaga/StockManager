class CreateStockTotals < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_totals do |t|
      t.integer :price
      t.integer :amount
      t.references :stock_list, foreign_key: true

      t.timestamps
    end
  end
end
