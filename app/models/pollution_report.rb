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
