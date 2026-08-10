class DepartmentsController < ApplicationController
  def index
    departments = DepartmentResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: departments }
      format.json { render json: departments }
    end
  end

  def show
    department = DepartmentResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: department }
      format.json { render json: department }
    end
  end

  def create
    department = DepartmentResource.build(params)

    if department.save
      render jsonapi: department, status: 201
    else
      render jsonapi_errors: department
    end
  end

  def update
    department = DepartmentResource.find(params)

    if department.update_attributes
      render jsonapi: department
    else
      render jsonapi_errors: department
    end
  end

  def destroy
    department = DepartmentResource.find(params)

    if department.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: department
    end
  end
end
