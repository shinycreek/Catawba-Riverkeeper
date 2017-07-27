AdminUser.where(email: 'admin@example.com').first_or_create do |user|
  user.password = '123456789'
  user.password_confirmation = '123456789'
end

#Temp creating Dam record. 
#Need to remove once 3rd party API intergrated
Dam.destroy_all

["Bridgewater", "Oxford", "Wylie", "Wateree"].each do |dam_name|
  dam = Dam.new(name: dam_name)
  if dam.save
    3.times do |i|
      WaterRelease.create(dam_id: dam.id, start_at: Time.now - (i+2).days, stop_at: Time.now - (i+1).days)
    end
  else
    puts "#{dam_name} Dam could not create!"
  end

  ["Watermill", "Catawba Intake", "Morganton Greenway", "Watermill Road Access Area"].each do |flow_arrival_location_name|
    flow_arrival_location = FlowArrivalLocation.new(dam_id: dam.id, name: flow_arrival_location_name)
    if flow_arrival_location.save
      3.times do |i|
        FlowArrivalRecession.create(flow_arrival_location_id: flow_arrival_location.id, arrival_time: Time.now - (i+2).days, recedes_time: Time.now - (i+1).days)
      end
    else
      puts "#{flow_arrival_location_name} FlowArrivalLocation could not create!"
    end
  end
end

LakeLevel.destroy_all

lake_level_names = ['Lake James', 'Lake Rhodhiss', 'Lake Dearbborn', 'Lake Hickory', 'Lake Norman', 'Lake Wylie']
lake_level_names.each do |lake_name|
  LakeLevel.create(lake_name: lake_name, level: rand(10.0..100).round(2), target: rand(10.0..100).round(2))
end