class Employee < ApplicationRecord
  has_many :positions
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :notes, as: :notable
  has_one :current_position,
    -> { current(true) },
    class_name: 'Position'
end
