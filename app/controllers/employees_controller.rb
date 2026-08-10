class EmployeesController < ApplicationController
  def index
    employees = EmployeeResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: employees }
      format.json { render json: employees }
    end
  end

  def show
    employee = EmployeeResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: employee }
      format.json { render json: employee }
    end
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
