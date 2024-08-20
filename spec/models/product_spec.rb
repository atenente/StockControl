require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:company) { create(:company) }
  let(:user) { create(:user, role: :nil, company: company) }
  let(:product) { create(:product, company: company) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is invalid without a sku" do
      product.sku = nil
      expect(product).not_to be_valid
    end

    it "is invalid with a non-unique sku within the same company" do
      another_product = build(:product, sku: product.sku, company: company)
      expect(another_product).not_to be_valid
    end

    it "is valid with a unique sku across different companies" do
      another_company = create(:company)
      another_product = build(:product, sku: product.sku, company: another_company)
      expect(another_product).to be_valid
    end

    it "is invalid with a non-numeric price" do
      product.price = "ten"
      expect(product.price).to eq(0.0)
    end

    it "is invalid with a non-integer stock" do
      product.stock = 10.5
      expect(product).not_to be_valid
    end

    it "is invalid with a description longer than 255 characters" do
      product.description = "a" * 256
      expect(product).not_to be_valid
    end
  end

  describe "callbacks" do
    it "converts price to a float with a dot as decimal separator before validation" do
      product.price = 10.50
      product.valid?
      expect(product.price).to eq(10.50)
    end
  end

  describe "associations" do
    it "belongs to a company" do
      expect(product.company).to eq(company)
    end
  end
end
