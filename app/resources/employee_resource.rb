class EmployeeResource < ApplicationResource
  attribute :id, :integer_id do
    if @object.id == 1
      'c29saWNpdGF0aW9uLTEyMTEwMzY='
    else
      @object.id
    end
  end

  attribute :foo, :string, only: [:readable] do
    'asdfasfds'
  end

  attribute :bar, :string, only: [:readable] do
    'jyhgbsdfdsf'
  end


  attribute :first_name, :string
  attribute :last_name, :string
  attribute :age, :integer
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :title, :string, only: [:filterable, :sortable]

  has_many :positions
  has_many :tasks
  many_to_many :teams
  polymorphic_has_many :notes, as: :notable
  has_one :current_position, resource: PositionResource do
    params do |hash|
      hash[:filter][:current] = true
    end
  end

  filter :title, only: [:eq] do
    eq do |scope, value|
      scope.joins(:current_position).merge(Position.where(title: value))
    end
  end

  sort :title do |scope, value|
    scope.joins(:current_position).merge(Position.order(title: value))
  end

  sort :department_name, :string do |scope, value|
    scope.joins(current_position: :department)
      .merge(Department.order(name: value))
  end
end
