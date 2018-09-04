class TeamResource < ApplicationResource
  attribute :department_id, :integer, only: [:filterable]
  attribute :name, :string

  belongs_to :department
  many_to_many :employees
end
