class Api::V1::RecreationalReleasesController < ApplicationController

  def index
    # releases are ordered and scoped in jbuilder view
    @dams = Dam.all.includes(:water_releases)
  end

  def flow_arrival_locations
    dam = Dam.find(params[:id])
    @flow_arrival_locations = dam.flow_arrival_locations
  end
end
