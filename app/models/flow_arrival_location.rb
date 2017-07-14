class FlowArrivalLocation < ApplicationRecord
  belongs_to :dam
  has_many :flow_arrival_recessions, dependent: :destroy
end
