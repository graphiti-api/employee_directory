class TeamsController < ApplicationController
  def index
    teams = TeamResource.all(params)
    respond_with(teams)
  end

  def show
    team = TeamResource.find(params)
    respond_with(team)
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
