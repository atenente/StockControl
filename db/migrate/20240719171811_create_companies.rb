class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies, id: :string, primary_key: :token do |t|
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
