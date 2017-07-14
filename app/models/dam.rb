class Dam < ApplicationRecord
  has_many :water_releases, dependent: :destroy
  has_many :flow_arrival_locations, dependent: :destroy
  has_many :flow_arrival_recessions, through: :flow_arrival_locations
end
