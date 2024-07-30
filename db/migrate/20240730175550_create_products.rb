class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :sku, limit: 255, null: false
      t.string :description, limit: 255
      t.decimal :price, precision: 10, scale: 2, default: 0.00
      t.integer :stock, default: 0
      t.string :supplier
      t.string :size
      t.string :color
      t.string :kind
      t.string :company_token, null: false

      t.timestamps
    end
  end
end
