class Api::V1::LakeLevelsController < ApplicationController

  def index
    @lake_levels = Lake.all.map do |lake|
      lake.lake_levels.by_date_recorded.last
    end
  end
end
