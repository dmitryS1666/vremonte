FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    before(:create, &:skip_confirmation!)
    sequence(:email) { |n| "user-12#{n}@test.ru" }
    password '12345678'
    password_confirmation '12345678'
  end
end
