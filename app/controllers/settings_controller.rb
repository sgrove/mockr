class SettingsController < ApplicationController
  def general
    # @setting = Setting.find_or_create_by_key("notification_email")
    @setting = Setting.find_or_create_by_key("bushido_dns")
  end

  # NOTE: now editing multiple records in update_all action. That should suffice
  #def update
    #setting = Setting.find_by_key(params[:setting][:key])
    #setting.update_attributes(params[:setting])
    #flash[:notice] = "Settings saved!"
    #redirect_to :back
  #end

  def update_all
    @settings = Setting.update(params[:settings].keys, params[:settings].values).reject { |p| p.errors.empty? }
    if @settings.empty?
      flash[:notice] = "settings updated"
      redirect_to general_settings_url
    else
      render :action => "general"
    end
  end

end
