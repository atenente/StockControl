FactoryBot.define do
  factory :company do
    token { 'ZleoDFa' }
    name { "company1" }
    address { "teste" }
    city { "teste" }
    state { "teste" }
    zip_code { "teste" }
    cnpj { Faker::Number.number(digits: 10).to_i }

    trait :company2 do
      token { 'ZleoDFb' }
      name { "company2" }
      address { "teste2" }
      city { "teste2" }
      state { "teste2" }
      zip_code { "teste2" }
      cnpj { Faker::Number.number(digits: 10).to_i }
    end
  end
end
