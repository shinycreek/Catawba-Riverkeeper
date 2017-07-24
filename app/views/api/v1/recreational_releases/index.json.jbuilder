json.dams @dams do |dam|
  json.id dam.id
  json.name dam.name
  json.water_releases dam.water_releases do |wr|
    json.start_at wr.start_at.strftime("%b %e, %l:%M %p")
    json.stop_at wr.stop_at.strftime("%b %e, %l:%M %p")
  end
end