class Team < ApplicationRecord
  belongs_to :department
  has_many :team_memberships
  has_many :employees, through: :team_memberships
end
