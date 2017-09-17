class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.integer :stock_code
      t.string :name
      t.integer :market_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
