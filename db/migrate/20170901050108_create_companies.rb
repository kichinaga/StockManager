class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.integer :stock_code
      t.string :name
      t.references :market
      t.references :industry

      t.timestamps
    end
  end
end
