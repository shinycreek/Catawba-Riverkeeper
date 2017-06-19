class Api::V1::WebsitesController < ApplicationController

  def basin_map
    @basin_map = Website.basinmap.first
    if !@basin_map
      render :json => {:error => I18n.t("messages.not_found"), :success => 0}, :status => :ok
    end
  end

  def crf
    @crf = Website.crf.first
    if !@crf
      render :json => {:error => I18n.t("messages.not_found"), :success => 0}, :status => :ok
    end
  end
end
