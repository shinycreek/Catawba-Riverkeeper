json.dams @dams do |dam|
  json.name dam.name
  json.water_releases dam.water_releases.last(3) do |wr|
    json.start_at wr.start_at
    json.stop_at wr.stop_at
  end
end