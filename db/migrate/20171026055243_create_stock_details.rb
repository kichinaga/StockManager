class CreateStockDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_details do |t|
      t.references :company, foreign_key: true
      t.string :price
      t.string :change
      t.string :prev_close_price
      t.string :open_price
      t.string :high_price
      t.string :low_price
      t.string :volume
      t.string :total_trade

      t.timestamps
    end
  end
end
