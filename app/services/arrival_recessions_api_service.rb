class ArrivalRecessionsAPIService

  def initialize
    # recession/1 is the Catawba River
    response = Faraday.get('https://lakes.duke-energy.com/Data/recession/1.txt')
    @dams_data_array = JSON.parse(response.body)
  end

  def call
    create_locations_and_arrival_reccessions_for_dams(@dams_data_array)
  end

  private

  def create_locations_and_arrival_reccessions_for_dams(dams_data_array)
    dams_data_array.map do |dam_data|
      dam_record = Dam.where(name: dam_data["DamName"]).first_or_create!
      create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
    end
  end

  def create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
    dam_data["FlowArrivalRecessions"].map do |location_data|
      location_record = create_arrival_location(dam_record, location_data)
      create_arrival_reccession(location_record, location_data)
    end
  end

  def create_arrival_location(dam_record, location_data)
    dam_record.flow_arrival_locations.where(
      name: get_location_name(location_data)
    ).first_or_create!
  end

  # sometimes the api returns a second arrival recession with no name
  # it is immediately preceeded by a first arrival_reccession with the correct
  def get_location_name(location_data)
    data_name = location_data["MileMarkerName"]
    data_name != "" ? data_name : FlowArrivalLocation.last.name
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
