# == Schema Information
#
# Table name: water_releases
#
#  id         :integer          not null, primary key
#  dam_id     :integer
#  start_at   :datetime
#  stop_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_water_releases_on_dam_id  (dam_id)
#

class WaterRelease < ApplicationRecord
  belongs_to :dam
end
