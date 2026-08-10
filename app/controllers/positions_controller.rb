class PositionsController < ApplicationController
  def index
    positions = PositionResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: positions }
      format.json { render json: positions }
    end
  end

  def show
    position = PositionResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: position }
      format.json { render json: position }
    end
  end

  def create
    position = PositionResource.build(params)

    if position.save
      render jsonapi: position, status: 201
    else
      render jsonapi_errors: position
    end
  end

  def update
    position = PositionResource.find(params)

    if position.update_attributes
      render jsonapi: position
    else
      render jsonapi_errors: position
    end
  end

  def destroy
    position = PositionResource.find(params)

    if position.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: position
    end
  end
end
