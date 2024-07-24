class AddCompanyTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :company_token, :string
    add_foreign_key :users, :companies, column: :company_token, primary_key: :token
  end
end
