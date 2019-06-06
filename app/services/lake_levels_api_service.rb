class LakeLevelsAPIService

  def initialize
    # service was written to allow for updating existing records, but due to the
    # instability of the api, destroy_all is called in job.
    response = Faraday.get('https://lakes.duke-energy.com/Data/Lakes/1.txt')
    @lake_levels_data_array = JSON.parse(response.body)
  end

  def call
    create_lakes_and_levels(@lake_levels_data_array)
  end

  private

  def create_lakes_and_levels(lake_levels_data_array)
    @lake_levels_data_array.map do |lake_data|
      begin
        lake = Lake.where(name: lake_data["LakeDisplayName"], api_lake_id: lake_data["LakeId"]).first_or_create!
        create_lake_levels(lake, lake_data)
      rescue ActiveRecord::RecordInvalid => e
        Honeybadger.notify(e)
      end
    end
  end

  def create_lake_levels(lake, lake_data)
    lake_level = lake.lake_levels.where(
      date_recorded: Date.strptime(lake_data["Date"], '%m/%d/%Y')
    ).first_or_create

    news_date = lake_data["SpecialMessageUpdated"]
    news = DateTime.strptime(news_date, '%m/%d/%Y %I:%M:%S %p') if news_date.present?
    lake_level.update(
      level: lake_data["Actual"],
      target: lake_data["Target"],
      news: news,
    )
  end
end
