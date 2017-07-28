class LakeLevelsAPIService

  def initialize
    response = Faraday.get('https://lakes.duke-energy.com/Data/Lakes/1.txt')
    @lake_levels_data_array = JSON.parse(response.body)
  end

  def call
    @lake_levels_data_array.map do |lake_data|
      lake = Lake.where(name: lake_data["LakeDisplayName"]).first_or_create
      lake.lake_levels.where(
        level: lake_data["Actual"],
        target: lake_data["Target"]
      ).first_or_create
    end
  end
end
