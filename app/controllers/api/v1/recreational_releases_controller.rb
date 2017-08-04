class Api::V1::RecreationalReleasesController < ApplicationController

  def index
    # releases are ordered and scoped in jbuilder view
    @dams = Dam.all.includes(:water_releases)
  end

  def flow_arrival_locations
    dam = Dam.find(params[:id])
    @flow_arrival_locations = dam.flow_arrival_locations.select do |floc|
      floc.flow_arrival_recessions.today_and_future.present?
    end.sort_by do |floc|
      floc.flow_arrival_recessions.today_and_future.first.arrival_time ?
      floc.flow_arrival_recessions.today_and_future.first.arrival_time :
      floc.flow_arrival_recessions.today_and_future.first.date
    end
  end
end
