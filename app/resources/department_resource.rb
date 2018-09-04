class DepartmentResource < ApplicationResource
  attribute :name, :string

  has_many :positions
  has_many :teams
end
