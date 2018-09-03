class EmployeesController < ApplicationController
  def index
    employees = EmployeeResource.all(params)
    respond_with(employees)
  end

  def show
    employee = EmployeeResource.find(params)
    respond_with(employee)
  end

  def create
    employee = EmployeeResource.build(params)

    if employee.save
      render jsonapi: employee, status: 201
    else
      render jsonapi_errors: employee
    end
  end

  def update
    employee = EmployeeResource.find(params)

    if employee.update_attributes
      render jsonapi: employee
    else
      render jsonapi_errors: employee
    end
  end

  def destroy
    employee = EmployeeResource.find(params)

    if employee.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: employee
    end
  end
end
