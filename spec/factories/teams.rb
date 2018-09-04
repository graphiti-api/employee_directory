FactoryBot.define do
  factory :team do
    department

    name { Faker::Lorem.word }
  end
end
