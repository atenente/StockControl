class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.integer :sku
      t.string :description
      t.float :price, default: 0
      t.integer :stock, default: 0
      t.string :supplier
      t.string :size
      t.string :color
      t.string :kind

      t.timestamps
    end
  end
end
