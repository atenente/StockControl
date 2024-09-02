class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.string :sku, null: false
      t.integer :quantity, default: 1
      t.decimal :price, precision: 10, scale: 2, default: 0.00
      t.decimal :total_quantity, precision: 10, scale: 2, default: 0.00
      t.integer :total_value, default: 1
      t.string :payment_method, default: 'cash'
       t.string :payment_local, default: 'store'
      t.integer :payment_split, default: 1
      t.text :others
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: { to_table: :companies, primary_key: :token }, type: :string

      t.timestamps
    end
  end
end
