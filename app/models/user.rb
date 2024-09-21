class User < ApplicationRecord
  belongs_to :company
  has_many :sales
  has_many :invoices

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validate :validate_company_id
  enum role: {user: 'user', admin: 'admin'}

  private

  def validate_company_id
    return if role == 'admin'
    unless Company.exists?(token: company_id)
      errors.add(:company_id, I18n.t('errors.messages.token_invalid'))
    end
  end

end
