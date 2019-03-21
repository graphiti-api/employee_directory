class DepartmentResource < ApplicationResource
  attribute :name, :string

  has_many :positions
  has_many :teams
  polymorphic_has_many :notes, as: :notable

  filter :employee_id, :integer, only: [:eq] do
    eq do |scope, value|
      scope.eager_load(:positions).merge(Position.where(employee_id: value))
    end
  end
end
