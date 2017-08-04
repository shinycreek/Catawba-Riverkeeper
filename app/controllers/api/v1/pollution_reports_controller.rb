class Api::V1::PollutionReportsController < ApplicationController

  def create
    pollution_report = PollutionReport.new(pollution_report_params)
    if pollution_report.save
      Rails.logger.debug "Calling arcgis API"
      PostPollutionReportJob.perform_later(pollution_report.id)
      do_render("notice", "messages.created", 1)
    else
      Rails.logger.debug "Controller error - did not save pollution report"
      do_render("error", "messages.not_create", 0)
    end
  end

  private

  def pollution_report_params
    params.require(:pollution_report).permit(:pollution_observed_at, :describe_pollution, :waterway_affected, :pollution_duration, :phone_id, :latitude, :longitude, :county, :address, :responsible_party, :other_information, upload_images_attributes: [:image])
  end

end
