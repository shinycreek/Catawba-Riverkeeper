namespace :duke_api_service do
  desc "TODO"
  task update_db_from_api: :environment do
    DukeAPIJob.perform_now
  end

  task update_lake_levels: :environment do
    Lake.destroy_all
    LakeLevelsAPIService.new.call
  end
end
