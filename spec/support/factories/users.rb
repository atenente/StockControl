FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { :user }
    company_token { nil }

    association :company, factory: :company

    trait :admin do
      role { :admin }
      company_token { nil }
    end
  end
end
