FactoryBot.define do
  factory :department do
    name { Faker::Lorem.word.titleize }
  end
end
