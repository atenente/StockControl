FactoryBot.define do
  factory :product_1 do
    sku { 'Sku123' }
    description { 'A great product1' }
    price { 10.23 }
    stock { 10 }
    supplier { 'Supplier A' }
    size { 'M' }
    color { 'Red' }
    kind { 'Type A' }
    company_id { nil }

    association :company, factory: :company

    trait :product_2 do
      sku { 'Sku1234' }
      description { 'A great product2' }
      price { 12.23 }
      stock { 20 }
      supplier { 'Supplier A' }
      size { 'M' }
      color { 'Red' }
      kind { 'Type A' }
      company_id { nil }
    end
  end
end
