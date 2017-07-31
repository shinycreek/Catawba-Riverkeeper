json.dams @dams do |dam|
  json.id dam.id
  json.name dam.name
  json.water_releases dam.water_releases.order(:date).last(3) do |wr|
    json.date wr.date.strftime("%b %e")
    json.generation wr.generation
    if wr.generation
      json.start_at wr.start_at.strftime("%b %e, %l:%M %p")
      json.stop_at wr.stop_at.strftime("%b %e, %l:%M %p")
      json.units wr.units
    end
  end
end
