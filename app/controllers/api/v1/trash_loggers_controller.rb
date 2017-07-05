class Api::V1::TrashLoggersController < ApplicationController

  def create
    trash_logger = TrashLogger.new(trash_logger_params)
    if trash_logger.save
      do_render("notice", "messages.created", 1)
    else
      do_render("error", "messages.not_create", 0)
    end
  end

  private
  
  def trash_logger_params
    params.require(:trash_logger).permit(:describe_trash, :describe_location, :adjacent_waterway, :phone_id, :latitude, :longitude, trash_logger_images_attributes: [:image])
  end

end