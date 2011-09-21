class SettingsController < ApplicationController
  def general
    # @setting = Setting.find_or_create_by_key("notification_email")
    @setting = Setting.find_or_create_by_key("bushido_dns")
  end
  
  def update
    setting = Setting.find_by_key(params[:setting][:key])
    setting.update_attributes(params[:setting])
    flash[:notice] = "Settings saved!"
    redirect_to :back
  end
end
