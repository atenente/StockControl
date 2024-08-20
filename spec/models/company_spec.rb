require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { create(:company) }
  let(:user) { create(:user, role: :user, company: company) }
  let(:product) { create(:product, company: company) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(company).to be_valid
    end

    it "is invalid without a name" do
      company.name = nil
      expect(company).not_to be_valid
    end

    it "is invalid without a cnpj" do
      company.cnpj = nil
      expect(company).not_to be_valid
    end

    it "is invalid with a non-unique cnpj" do
      another_company = build(:company, cnpj: company.cnpj)
      expect(another_company).not_to be_valid
    end

    it "is invalid with a non-unique token" do
      another_company = build(:company, token: company.token)
      expect(another_company).not_to be_valid
    end
  end

  describe "callbacks" do
    it "generates a unique token before creation" do
      expect(company.token).to be_present
    end

    it "does not generate duplicate tokens" do
      existing_token = company.token
      new_company = create(:company)
      expect(new_company.token).not_to eq(existing_token)
    end
  end

  describe "associations" do
    it "can have many users" do
      user1 = create(:user, company: company)
      user2 = create(:user, company: company)
      expect(company.users).to include(user1, user2)
    end

    it "can have many products" do
      product = create(:product, company: company)
      product2 = create(:product, company: company)
      expect(company.products).to include(product, product2)
    end
  end
end
