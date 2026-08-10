class TasksController < ApplicationController
  def index
    tasks = TaskResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: tasks }
      format.json { render json: tasks }
    end
  end

  def show
    task = TaskResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: task }
      format.json { render json: task }
    end
  end

  def create
    task = TaskResource.build(params)

    if task.save
      render jsonapi: task, status: 201
    else
      render jsonapi_errors: task
    end
  end

  def update
    task = TaskResource.find(params)

    if task.update_attributes
      render jsonapi: task
    else
      render jsonapi_errors: task
    end
  end

  def destroy
    task = TaskResource.find(params)

    if task.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: task
    end
  end
end
