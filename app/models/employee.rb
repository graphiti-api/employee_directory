class Employee < ApplicationRecord
  has_many :positions
  has_many :team_memberships
  has_many :teams, through: :team_memberships
  has_many :notes, as: :notable
  has_many :tasks
  has_many :bugs
  has_many :features
  has_many :epics
  has_one :current_position,
    -> { current(true) },
    class_name: 'Position'
end
