FactoryBot.define do
  factory :user do
    name      { Faker::Internet.name }
    email     { Faker::Internet.free_email }
    password  { 'xxx123' }
  end
end
