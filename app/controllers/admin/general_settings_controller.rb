class Admin::GeneralSettingsController < ApplicationController
  load_and_authorize_resource

  def edit
    @general_setting = GeneralSetting.find(params[:id])
  end

  def update
    @general_setting = GeneralSetting.find(params[:id])
    if @general_setting.update(setting_params)
      flash[:notice] = "Your settings were updated"
      redirect_to dashboards_path
    else
      flash[:error] = "Could not save the settings"
      render edit_admin_general_setting_path
    end
  end

  private

  def setting_params
    params.require(:general_setting).permit(:title, :header, :subheader, :template)
  end
end
