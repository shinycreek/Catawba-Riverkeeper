class Api::V1::PollutionReportsController < ApplicationController

  def create
    pollution_report = PollutionReport.new(pollution_report_params)
    if pollution_report.save
      do_render("notice", "messages.created", 1)
    else
      do_render("error", "messages.not_create", 0)
    end
  end

  private

  def pollution_report_params
    params.require(:pollution_report).permit(:pollution_observed_at, :describe_pollution, :waterway_affected, :pollution_duration, :phone_id, :latitude, :longitude, upload_images_attributes: [:image])
  end

end
