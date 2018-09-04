[
  Employee,
  Position,
  Department,
  TeamMembership,
  Team
].each(&:delete_all)

departments = []
def create_department(name)
  dept = Department.create! name: name
  dept.teams.create!(name: 'Engineering Team B')
  dept.teams.create!(name: 'Engineering Team C')
  dept
end

departments << create_department('Engineering')
departments << create_department('Safety')
departments << create_department('QA')

100.times do
  employee = Employee.create! first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(20..80)

  (1..2).each do |i|
    employee.positions.create! title: Faker::Job.title,
      historical_index: i,
      active: i == 1,
      department: departments.sample
  end

  employee.teams << employee.positions[0].department.teams.sample
end
