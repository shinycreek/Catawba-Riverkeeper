json.user_setting do   
  json.(@user_setting, :first_name, :last_name, :email, :phone, :country, :address, :city, :state, :zip, :phone_id)
end
json.success 1
