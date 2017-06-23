class Api::V1::UserSettingsController < ApplicationController
  
  def setting
    user_setting = UserSetting.where(phone_id: user_setting_params[:phone_id]).first_or_initialize
    if user_setting.update_attributes(user_setting_params)
      do_render("notice", "messages.updated", 1) 
    else
      do_render("error", "messages.not_update", 0)
    end
  end

  def show
    @user_setting = UserSetting.find_by_phone_id(params[:phone_id])
    do_render("error", "messages.not_found", 0) if @user_setting.nil? 
  end

  private
  
  def user_setting_params
    params.require(:user_setting).permit(:first_name, :last_name, :email, :phone, :country, :address, :city, :state, :zip, :phone_id)
  end
  
end
