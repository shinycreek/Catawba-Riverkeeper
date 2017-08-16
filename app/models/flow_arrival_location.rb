# == Schema Information
#
# Table name: flow_arrival_locations
#
#  id         :integer          not null, primary key
#  dam_id     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_flow_arrival_locations_on_dam_id  (dam_id)
#

class FlowArrivalLocation < ApplicationRecord
  belongs_to :dam
  has_many :flow_arrival_recessions, dependent: :destroy
  validates :dam_id, :name, presence: true
end
