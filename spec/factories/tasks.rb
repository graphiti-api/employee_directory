FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word.titleize }
    type { Task::TYPES.sample }
  end

  factory :bug, parent: :task, class: 'Bug' do
    type { 'Bug' }
  end

  factory :feature, parent: :task, class: 'Feature' do
    type { 'Feature' }
  end

  factory :epic, parent: :task, class: 'Epic' do
    type { 'Epic' }
  end
end
