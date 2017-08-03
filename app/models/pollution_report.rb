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
#  county                :string
#  address               :string
#  responsible_party     :string
#  other_information     :string
#

class PollutionReport < ApplicationRecord

  has_many :upload_images, as: :imageable
  accepts_nested_attributes_for :upload_images

  #after_save :send_to_arcgis

  private

  def send_to_arcgis
    Rails.logger.debug "Calling arcgis API"
    PostPollutionReportJob.perform_later(self.id)
    return true
  end
end
