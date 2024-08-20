FactoryBot.define do
  factory :product do
    sku { Faker::Alphanumeric.alphanumeric(number: 7) }
    description { 'A great product1' }
    price { 10.23 }
    stock { 10 }
    supplier { 'Supplier A' }
    size { 'M' }
    color { 'Red' }
    kind { 'Type A' }
    company_id { company.id }

    association :company, factory: :company
  end
end
