class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.integer :quantity, default: 1
      t.decimal :price, precision: 10, scale: 2, default: 0.00
      t.integer :sum_price, precision: 10, scale: 2, default: 0.00
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: { to_table: :companies, primary_key: :token }, type: :string
      t.references :product, null: false, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
