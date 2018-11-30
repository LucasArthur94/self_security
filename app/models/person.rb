class Person < ApplicationRecord
  has_many :devices
  validates_uniqueness_of :email
end
