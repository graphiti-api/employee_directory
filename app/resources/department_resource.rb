class DepartmentResource < ApplicationResource
  attribute :name, :string

  has_many :positions
  has_many :teams
  polymorphic_has_many :notes, as: :notable
  has_many :watchers, resource: EmployeeResource do
    params do |hash, departments|
      hash[:filter] = { email: departments.map(&:watcher_emails).flatten }
    end

    assign do |departments, employees|
      departments.each do |d|
        d.watchers = employees.select do |e|
          e.email.in?(d.watcher_emails)
        end
      end
    end
  end
end
