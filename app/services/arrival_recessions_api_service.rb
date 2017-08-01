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
    get_location_indexes(dam_data).map do |index|
      location_data_array = get_location_data_by_index(dam_data, index)
      location_record = create_arrival_location(dam_record, location_data_array)
      create_arrival_reccessions_for_location(location_record, location_data_array)
    end
  end

  def get_location_indexes(dam_data)
    dam_data["FlowArrivalRecessions"].map { |location| location["Index"] }.uniq
  end

  def get_location_data_by_index(dam_data, index)
    dam_data["FlowArrivalRecessions"].select do |location_data|
      location_data["Index"] == index
    end
  end

  def create_arrival_location(dam_record, location_data_array)
    dam_record.flow_arrival_locations.where(
      name: get_location_name(location_data_array)
    ).first_or_create!
  end

  def get_location_name(location_data_array)
    location_data_array.map do |location_data|
      location_data["MileMarkerName"]
    end.compact[0]
  end

  def create_arrival_reccessions_for_location(location_record, location_data_array)
    location_data_array.map do |location_data|
      create_arrival_reccession(location_record, location_data)
    end
  end

  def create_arrival_reccession(location_record, location_data)
    location_record.flow_arrival_recessions.where(
      arrival_time: DateTime.parse(location_data["Arrival"]),
      recedes_time: DateTime.parse(location_data["Recedes"])
    ).first_or_create!
  end
end
