FactoryBot.define do
  factory :note do
    body { Faker::Lorem.sentence }
  end

  factory :employee_note, parent: :note do
    association :notable, factory: :employee
  end

  factory :department_note, parent: :note do
    association :notable, factory: :department
  end

  factory :team_note, parent: :note do
    association :notable, factory: :team
  end
end
