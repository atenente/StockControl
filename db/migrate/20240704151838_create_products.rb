class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :description, limit: 255
      t.float :price, default: 0.0
      t.integer :stock, default: 0
      t.string :supplier
      t.string :size
      t.string :color
      t.string :kind

      t.timestamps
    end
  end
end
