class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :payment_method, default: 'cash'
      t.string :payment_local, default: 'store'
      t.integer :payment_split, default: 1
      t.decimal :total_value, null: false, precision: 10, scale: 2
      t.integer :total_quantity, null: false
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: { to_table: :companies, primary_key: :token }, type: :string

      t.timestamps
    end
  end
end
