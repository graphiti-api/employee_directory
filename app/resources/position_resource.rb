class PositionResource < ApplicationResource
  attribute :employee_id, :integer, readable: false
  attribute :department_id, :integer, readable: false
  attribute :title, :string
  attribute :historical_index, :integer, only: [:sortable]
  attribute :active, :boolean

  belongs_to :employee
  belongs_to :department

  filter :current, :boolean do
    eq { |scope, value| scope.current(value) }
  end

  before_commit only: [:create, :destroy] do |position|
    Position.reorder!(position.employee_id)
  end
end
