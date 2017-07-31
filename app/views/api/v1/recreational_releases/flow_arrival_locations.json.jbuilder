json.flow_arrival_locations @flow_arrival_locations do |fal|
  json.name fal.name
  json.flow_arrival_recessions fal.flow_arrival_recessions.order(:arrival_time).last(1) do |far|
    json.arrival_time far.arrival_time.strftime("%b %e, %l:%M %p")
    json.recedes_time far.recedes_time.strftime("%b %e, %l:%M %p")
  end
end
