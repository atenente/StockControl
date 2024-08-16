class User < ApplicationRecord
  belongs_to :company, foreign_key: 'token', foreign_key: 'company_id'

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validate :validate_company_id
  enum role: {user: 'user', admin: 'admin'}

  private

  def validate_company_id
    return true if role == 'admin'
    unless Company.exists?(token: company_id)
      errors.add(:company_id, "is invalid. Please provide a valid company token.")
    end
  end

end
