class ArrivalRecessionAPIService

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
      dam_record = Dam.where(name: dam_data["DamName"]).first_or_create
      create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
    end
  end

  def create_locations_and_arrival_reccessions_for_dam(dam_record, dam_data)
    dam_data["FlowArrivalRecessions"].map do |arr_rec_data|
      unless arr_rec_data["MileMarkerName"] == ""
        location_record = create_arrival_location(dam_record, arr_rec_data)
        create_arrival_reccession(location_record, arr_rec_data)
      end
    end
  end

  def create_arrival_reccession(location_record, arr_rec_data)
    location_record.flow_arrival_recessions.where(
      arrival_time: DateTime.parse(arr_rec_data["Arrival"]),
      recedes_time: DateTime.parse(arr_rec_data["Recedes"])
    ).first_or_create
  end

  def create_arrival_location(dam_record, arr_rec_data)
    dam_record.flow_arrival_locations.where(
      name: arr_rec_data["MileMarkerName"]
    ).first_or_create
  end
end
