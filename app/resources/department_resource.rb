class DepartmentResource < ApplicationResource
  attribute :name, :string

  has_many :positions
  has_many :teams
  polymorphic_has_many :notes, as: :notable
end
