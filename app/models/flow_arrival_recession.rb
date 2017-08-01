# == Schema Information
#
# Table name: flow_arrival_recessions
#
#  id                       :integer          not null, primary key
#  flow_arrival_location_id :integer
#  arrival_time             :datetime
#  recedes_time             :datetime
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_flow_arrival_recessions_on_flow_arrival_location_id  (flow_arrival_location_id)
#

class FlowArrivalRecession < ApplicationRecord
  belongs_to :flow_arrival_location
  validates :flow_arrival_location_id, :arrival_time, :recedes_time, presence: true
end
