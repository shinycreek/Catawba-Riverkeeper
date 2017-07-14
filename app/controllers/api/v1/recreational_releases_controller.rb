class Api::V1::RecreationalReleasesController < ApplicationController

  def index
    @dams = Dam.all.includes(:water_releases)
  end

  def flow_arrival_locations
    dam = Dam.find(params[:id])
    @flow_arrival_locations = dam.flow_arrival_locations
  end
end
