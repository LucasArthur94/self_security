class Device < ApplicationRecord
  belongs_to :person, optional: true
end
