class PositionsController < ApplicationController
  def index
    positions = PositionResource.all(params)
    respond_with(positions)
  end

  def show
    position = PositionResource.find(params)
    respond_with(position)
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
