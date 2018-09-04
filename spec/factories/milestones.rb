FactoryBot.define do
  factory :milestone do
    epic

    name { Faker::Lorem.word }
  end
end
