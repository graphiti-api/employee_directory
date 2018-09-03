FactoryBot.define do
  factory :employee do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    age { rand(20..80) }
  end
end
