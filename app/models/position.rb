class Position < ApplicationRecord
  belongs_to :employee
  belongs_to :department

  scope :current, -> { where(historical_index: 1) }
end
