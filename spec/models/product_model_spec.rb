require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    product = Product.new(sku: 'SKU1234', price: 'not_a_number', stock: 1.5, description: 'a' * 256)

    it 'validates presence of sku' do
      new_product = Product.new
      new_product.valid?
      expect(new_product.errors[:sku]).to include(I18n.t('errors.messages.blank'))
    end

    it 'validates uniqueness of sku' do
      duplicate_product = create(:product, sku: 'SKU1234')
      product.valid?
      expect(product.errors[:sku]).to include(I18n.t('errors.messages.taken'))
    end

    before(:each) do
      product.valid?
    end

    it 'validates numericality of price' do
      expect(product.errors[:price]).not_to eq(0.0)
    end

    it 'validates numericality of stock as integer' do
      expect(product.errors[:stock]).to include(I18n.t('errors.messages.not_an_integer'))
    end

    it 'validates length of description' do
      expect(product.errors[:description]).to include(I18n.t('errors.messages.too_long', count: 255))
    end
  end

  describe '#set_default_price' do
    it 'does not convert price if already in correct format' do
      product = Product.new(price: 100.50)
      product.send(:set_default_price)
      expect(product.price).to eq(100.50)
    end
  end
end
