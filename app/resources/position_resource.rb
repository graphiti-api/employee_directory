class PositionResource < ApplicationResource
  attribute :employee_id, :integer, readable: false
  attribute :title, :string
  attribute :historical_index, :integer, only: [:sortable]
  attribute :active, :boolean

  belongs_to :employee
end
