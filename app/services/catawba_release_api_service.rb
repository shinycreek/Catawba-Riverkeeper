class CatawbaReleaseAPIService

  def initialize
    response = Faraday.get('https://lakes.duke-energy.com/Data/flow/1.txt')
    @dams_data_array = JSON.parse(response.body)
  end

  def call
    create_releases_for_dams(@dams_data_array)
  end

  private

  def create_releases_for_dams(dams_data_array)
    dams_data_array.map do |dam_data|
      dam_record = Dam.where(name: dam_data["RiverName"]).first_or_create
      create_water_releases(dam_record, dam_data["Releases"])
    end
  end

  def create_water_releases(dam_record, releases_array)
    releases_array.map do |release_data|
      unless release_data["EndDateTime"] == "No Generation Scheduled"
        create_water_release(dam_record, release_data)
      end
    end
  end

  def create_water_release(dam_record, release_data)
    dam_record.water_releases.where(
      start_at: DateTime.strptime(release_data["StartDateTime"], '%m/%d/%Y %I:%M:%S %p'),
      stop_at: DateTime.strptime(release_data["EndDateTime"], '%m/%d/%Y %I:%M:%S %p')
    ).first_or_create
  end
end
