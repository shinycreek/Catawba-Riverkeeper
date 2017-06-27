class Api::V1::UserSettingsController < ApplicationController

  def create
    user_setting = UserSetting.new(user_setting_params)
    if user_setting.save
      do_render("notice", "messages.created", 1)
    else
      do_render("error", "messages.not_create", 0)
    end
  end

  def update
    user_setting = UserSetting.find_by_phone_id(user_setting_params[:phone_id])
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
