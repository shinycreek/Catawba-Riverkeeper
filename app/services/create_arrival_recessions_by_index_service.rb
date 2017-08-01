class CreateArrivalRecessionsByIndexService

  def initialize(dam_record, dam_data)
    @dam_record = dam_record
    @dam_data = dam_data
  end

  def call
    create_arrival_reccessions_for_dam_by_index(@dam_record, @dam_data)
  end

  private

  def create_arrival_reccessions_for_dam_by_index(dam_record, dam_data)
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
      date: DateTime.parse(location_data["Arrival"]).to_date
    ).first_or_create!(
      arrival_time: DateTime.parse(location_data["Arrival"]),
      recedes_time: DateTime.parse(location_data["Recedes"])
    )
  end
end
