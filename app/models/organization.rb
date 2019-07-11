class Organization < ApplicationRecord
  validates_presence_of :name
  enum state: [:pending, :active, :denied]
end
