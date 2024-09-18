FactoryBot.define do
  factory :invoice do
    payment_method { "MyString" }
    payment_local { "MyString" }
    payment_split { 1 }
    total_value { "9.99" }
    total_quantity { 1 }
    sale { nil }
    product { nil }
  end
end
