class LakeLevelsAPIService

  def initialize
    response = Faraday.get('https://lakes.duke-energy.com/Data/Lakes/1.txt')
    @lake_levels_data_array = JSON.parse(response.body)
  end

  def call
  end
end
