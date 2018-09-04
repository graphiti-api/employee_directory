class Department < ApplicationRecord
  has_many :positions
  has_many :teams
end
