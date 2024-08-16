class Company < ApplicationRecord
  has_many :users
  has_many :products

  before_create :generate_token

  validates :name, :cnpj, presence: true
  validates :token, :cnpj, uniqueness: true

  private

  def generate_token
    self.token = loop do
      random_token = SecureRandom.alphanumeric(7)
      break random_token unless Company.exists?(token: random_token)
    end
  end
end
