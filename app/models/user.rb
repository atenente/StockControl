class User < ApplicationRecord
  belongs_to :company, primary_key: 'token', foreign_key: 'company_token'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validate :validate_company_token

  private

  def validate_company_token
    unless Company.exists?(token: company_token)
      errors.add(:company_token, "is invalid. Please provide a valid company token.")
    end
  end

end
