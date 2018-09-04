FactoryBot.define do
  factory :position do
    employee
    department

    title { Faker::Job.title }

    after(:create) do |position|
      unless position.historical_index
        Position.reorder!(position.employee.id)
      end
    end
  end
end
