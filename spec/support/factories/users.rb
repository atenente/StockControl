FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { :user }
    company_id { 'ZleoDFb' }

    association :company, factory: :company

    trait :admin do
      role { :admin }
      company_id { nil }
    end
  end
end
