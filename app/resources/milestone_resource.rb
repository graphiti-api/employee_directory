class MilestoneResource < ApplicationResource
  attribute :epic_id, :integer, only: [:filterable]
  attribute :name, :string

  belongs_to :epic do
    link do |milestone|
      helpers = Rails.application.routes.url_helpers
      helpers.task_url(milestone.epic_id)
    end
  end
end
