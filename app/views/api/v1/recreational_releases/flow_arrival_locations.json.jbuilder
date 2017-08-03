json.flow_arrival_locations @flow_arrival_locations.sort_by {|loc| loc.flow_arrival_recessions.today_and_future.first.arrival_time } do |fal|
  json.name fal.name
  json.flow_arrival_recessions fal.flow_arrival_recessions.today_and_future do |far|
    json.arrival_time far.arrival_time.strftime("%b %e, %l:%M %p")
    json.recedes_time far.recedes_time.strftime("%b %e, %l:%M %p")
  end
end
