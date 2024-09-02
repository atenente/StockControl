FactoryBot.define do
  factory :sale do
    invoice { 1 }
    user { nil }
    product { nil }
    quantity { 1 }
    total_amount { "9.99" }
    payment_method { "MyString" }
    payment_split { 1 }
    payment_local { "MyString" }
    others { "MyText" }
  end
end
