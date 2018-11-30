class Device < ApplicationRecord
  belongs_to :person, optional: true
  validates_uniqueness_of :bluetooth_id
end
