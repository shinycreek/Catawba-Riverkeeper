class ApplicationController < ActionController::Base

  def do_render(msg_type, msg_locale, success)
    render :json => {msg_type.to_sym => I18n.t(msg_locale), :success => success}, :status => :ok
  end
end
