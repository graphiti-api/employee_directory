FactoryBot.define do
  factory :position do
    employee

    title { Faker::Job.title }

    after(:create) do |position|
      unless position.historical_index
        scope = Position
          .where(employee_id: position.employee.id)
          .order(created_at: :desc)
        scope.each_with_index do |p, index|
          p.update_attribute(:historical_index, index + 1)
        end
      end
    end
  end
end
