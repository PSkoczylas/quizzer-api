FactoryBot.define do
  factory :category do
    name { Faker::Educator.subject[1..30] }
    description { Faker::Lorem.sentence }
  end
end