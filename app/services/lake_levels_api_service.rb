class LakeLevelsAPIService

  def initialize
    response = Faraday.get('https://lakes.duke-energy.com/Data/Lakes/1.txt')
    @lake_levels_data_array = JSON.parse(response.body)
  end

  def call
    create_lakes_and_levels(@lake_levels_data_array)
  end

  private

  def create_lakes_and_levels(lake_levels_data_array)
    @lake_levels_data_array.map do |lake_data|
      lake = Lake.where(name: lake_data["LakeDisplayName"]).first_or_create!
      create_lake_levels(lake, lake_data)
    end
  end

  def create_lake_levels(lake, lake_data)
    lake.lake_levels.where(
      level: lake_data["Actual"],
      target: lake_data["Target"],
      date_recorded: Date.strptime(lake_data["Date"], '%m/%d/%Y')
    ).first_or_create!
  end
end
