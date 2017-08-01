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
    if dam_data["FlowArrivalRecessions"].map { |location| location["Index"] }.uniq.length == 1
      CreateArrivalRecessionsForSimpleArrayService.new(dam_record, dam_data).call
    else
      CreateArrivalRecessionsByIndexService.new(dam_record, dam_data).call
    end
  end
end
