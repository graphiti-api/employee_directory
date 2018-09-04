class Task < ApplicationRecord
  TYPES = %w(Bug Feature Epic)

  belongs_to :team, optional: true
  belongs_to :employee, optional: true
end
