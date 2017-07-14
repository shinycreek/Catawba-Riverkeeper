class Dam < ApplicationRecord
  has_many :water_releases
  has_many :flow_arrival_locations
  has_many :flow_arrival_recessions, through: :flow_arrival_locations
end
