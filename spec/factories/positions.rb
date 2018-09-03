FactoryBot.define do
  factory :position do
    employee

    title { Faker::Job.title }
    historical_index { 1 }

    before(:create) do |position|
      position.historical_index ||= position.employee.positions.count + 1
    end
  end
end
