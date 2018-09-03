class Employee < ApplicationRecord
  has_many :positions
  has_one :current_position,
    -> { current(true) },
    class_name: 'Position'
end
