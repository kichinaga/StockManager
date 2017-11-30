class CreateStockLists < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_lists do |t|
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true
      t.boolean :activated

      t.timestamps
    end
  end
end
