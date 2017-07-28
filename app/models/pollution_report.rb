# == Schema Information
#
# Table name: pollution_reports
#
#  id                    :integer          not null, primary key
#  describe_pollution    :text
#  phone_id              :string
#  latitude              :string
#  longitude             :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  pollution_duration    :string
#  waterway_affected     :string
#  pollution_observed_at :datetime
#

class PollutionReport < ApplicationRecord

  has_many :upload_images, as: :imageable
  accepts_nested_attributes_for :upload_images

end
