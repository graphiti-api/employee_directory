class EmployeeResource < ApplicationResource
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :age, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :title, :string, only: [:filterable, :sortable]

  has_many :positions

  filter :title, only: [:eq] do
    eq do |scope, value|
      scope.joins(:current_position).merge(Position.where(title: value))
    end
  end

  sort :title do |scope, value|
    scope.joins(:current_position).merge(Position.order(title: value))
  end
end
