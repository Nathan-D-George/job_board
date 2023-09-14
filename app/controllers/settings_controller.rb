class SettingsController < ApplicationController
  $settings_id = nil
  before_action :logged_in_only

  def edit
    @settings    = Setting.find(params[:id])
    $settings_id = params[:id].to_i
  end

  def update
    settings       = Setting.find($settings_id)
    settings.theme = params[:setting][:theme]
    if settings.save
      flash[:notice] = 'Settings Updated'
      redirect_to show_settings_path(id: settings.user_id)
    else
      flash.now[:alert] = 'Something went wrong'
      render :edit
    end
  end

  def show
    @settings = Setting.where(user_id: params[:id].to_i).first
  end

end
