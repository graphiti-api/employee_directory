class TeamsController < ApplicationController
  def index
    teams = TeamResource.all(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: teams }
      format.json { render json: teams }
    end
  end

  def show
    team = TeamResource.find(params)
    respond_to do |format|
      format.jsonapi { render jsonapi: team }
      format.json { render json: team }
    end
  end

  def create
    team = TeamResource.build(params)

    if team.save
      render jsonapi: team, status: 201
    else
      render jsonapi_errors: team
    end
  end

  def update
    team = TeamResource.find(params)

    if team.update_attributes
      render jsonapi: team
    else
      render jsonapi_errors: team
    end
  end

  def destroy
    team = TeamResource.find(params)

    if team.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: team
    end
  end
end
