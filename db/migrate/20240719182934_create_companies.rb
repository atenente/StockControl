class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :token
      t.string :name, limit: 255
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :cnpj

      t.timestamps
    end
  end
end
