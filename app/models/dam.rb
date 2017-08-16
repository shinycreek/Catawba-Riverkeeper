# == Schema Information
#
# Table name: dams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dam < ApplicationRecord
  has_many :water_releases, dependent: :destroy
  has_many :flow_arrival_locations, dependent: :destroy
  has_many :flow_arrival_recessions, through: :flow_arrival_locations
end
