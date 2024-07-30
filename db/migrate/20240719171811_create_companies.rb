class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies, id: false do |t|
      t.string :token, null: false, primary_key: true
      t.string :name, null: false, limit: 255
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :cnpj, null: false

      t.timestamps
    end
  end
end
