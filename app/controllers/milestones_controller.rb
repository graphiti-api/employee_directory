class MilestonesController < ApplicationController
  def index
    milestones = MilestoneResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: milestones }
      format.json { render json: milestones }
    end
  end

  def show
    milestone = MilestoneResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: milestone }
      format.json { render json: milestone }
    end
  end

  def create
    milestone = MilestoneResource.build(params)

    if milestone.save
      render jsonapi: milestone, status: 201
    else
      render jsonapi_errors: milestone
    end
  end

  def update
    milestone = MilestoneResource.find(params)

    if milestone.update_attributes
      render jsonapi: milestone
    else
      render jsonapi_errors: milestone
    end
  end

  def destroy
    milestone = MilestoneResource.find(params)

    if milestone.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: milestone
    end
  end
end
