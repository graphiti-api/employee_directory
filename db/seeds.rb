Employee.delete_all

100.times do
  Employee.create! first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: rand(20..80)
end
