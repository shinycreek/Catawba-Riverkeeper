class DukeAPIJob < ApplicationJob
  queue_as :default

  def perform
    Dam.destroy_all
    Lake.destroy_all
    DamReleasesAPIService.new.call
    ArrivalRecessionsAPIService.new.call
    LakeLevelsAPIService.new.call
  end
end
