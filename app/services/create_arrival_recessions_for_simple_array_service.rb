class CreateArrivalRecessionsForSimpleArrayService

  def initialize(dam_record, dam_data)
    @dam_record = dam_record
    @dam_data = dam_data
  end

  def call
    create_arrival_reccessions_for_dam(@dam_record, @dam_data)
  end

  private

  def create_arrival_reccessions_for_dam(dam_record, dam_data)
    dam_data["FlowArrivalRecessions"].map do |location_data|
      location_record = create_arrival_location(dam_record, location_data)
      create_arrival_reccession(location_record, location_data)
    end
  end

  def create_arrival_location(dam_record, location_data)
    dam_record.flow_arrival_locations.where(
      name: location_data["MileMarkerName"]
    ).first_or_create!
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
