class Api::V1::LakeLevelsController < ApplicationController

  def index
    @lake_levels = LakeLevel.all
  end

end
