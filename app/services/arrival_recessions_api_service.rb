class ArrivalRecessionsAPIService

  def initialize
    # service was written to allow for updating existing records, but due to the
    # instability of the api, destroy_all is called in job.
    # recession/1 is the Catawba River
    response = Faraday.get('https://lakes.duke-energy.com/Data/recession/1.txt')
    @dams_data_array = JSON.parse(response.body)
    binding.pry
  end

  def call
    create_locations_and_arrival_reccessions_for_dams(@dams_data_array)
  end

  private

  def create_locations_and_arrival_reccessions_for_dams(dams_data_array)
    dams_data_array.map do |dam_data|
      begin
        dam_record = Dam.where(name: dam_data["DamName"]).first_or_create!
        create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
      rescue ActiveRecord::RecordInvalid => e
        Honeybadger.notify(e)
      end
    end
  end

  def create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
    dam_data["FlowArrivalRecessions"].inject("") do |last_location_name, location_data|
      begin
        location_record = create_arrival_location(dam_record, location_data, last_location_name)
        create_arrival_reccession(location_record, location_data)
        location_record.name
      rescue ActiveRecord::RecordInvalid => e
        Honeybadger.notify(e)
        last_location_name
      end
    end
  end

  def create_arrival_location(dam_record, location_data, last_location_name)
    dam_record.flow_arrival_locations.where(
      name: get_location_name(location_data, last_location_name)
    ).first_or_create!
  end

  # sometimes the api returns a second arrival recession with no name
  # it is immediately preceeded by a first arrival_reccession with the name
  def get_location_name(location_data, last_location_name)
    data_name = location_data["MileMarkerName"]
    data_name != "" ? data_name : last_location_name
  end

  def create_arrival_reccession(location_record, location_data)
    arrival_reccession = location_record.flow_arrival_recessions.where(
      date: DateTime.parse(location_data["Arrival"]).to_date
    ).first_or_create
    arrival_reccession.update(
      arrival_time: DateTime.parse(location_data["Arrival"]),
      recedes_time: DateTime.parse(location_data["Recedes"])
    )
  end
end
