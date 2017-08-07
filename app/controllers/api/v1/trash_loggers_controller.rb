class Api::V1::TrashLoggersController < ApplicationController

  def create
    trash_logger = TrashLogger.new(trash_logger_params)
    if trash_logger.save
      Rails.logger.debug "Calling arcgis API for trash logger"
      PostTrashLoggerJob.perform_later(trash_logger.id)
      do_render("notice", "messages.created", 1)
    else
      do_render("error", "messages.not_create", 0)
    end
  end

  private

  def trash_logger_params
    params.require(:trash_logger).permit( :describe_trash, :describe_location, :adjacent_waterway, :phone_id, :latitude, :longitude, :county, upload_images_attributes: [:image] )
  end

end
