json.flow_arrival_locations @flow_arrival_locations do |fal|
  json.name fal.name
  json.flow_arrival_recessions fal.flow_arrival_recessions.last(3) do |far|
    json.arrival_time far.arrival_time
    json.recedes_time far.recedes_time
  end
end