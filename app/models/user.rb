class User < ApplicationRecord
  belongs_to :company, primary_key: 'token', foreign_key: 'company_token'

  has_many :products

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validate :validate_company_token
  enum role: {user: 'user', admin: 'admin'}

  private

  def validate_company_token
    return true if role == 'admin'
    unless Company.exists?(token: company_token)
      errors.add(:company_token, "is invalid. Please provide a valid company token.")
    end
  end

end
