class Position < ApplicationRecord
  belongs_to :employee
  belongs_to :department

  scope :current, ->(bool) {
    clause = { historical_index: 1 }
    bool ? where(clause) : where.not(clause)
  }
end
