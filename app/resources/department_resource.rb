class DepartmentResource < ApplicationResource
  attribute :name, :string

  has_many :positions
end
