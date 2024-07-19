FactoryBot.define do
  factory :product do
    sku { 'Sku123' }
    description { 'A great product' }
    price { 10.23 }
    stock { 10 }
    supplier { 'Supplier A' }
    size { 'M' }
    color { 'Red' }
    kind { 'Type A' }
  end
end
