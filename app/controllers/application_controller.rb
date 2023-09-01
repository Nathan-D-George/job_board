class ApplicationController < ActionController::Base
  before_action :set_current_user
  
  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def logged_in_only
    redirect_to new_session_path, alert: 'You must be signed in to do this' if Current.user.nil?
  end

  def correct_user_only
    redirect_to root_path, alert: 'Only the Account Owner can do this' if Current.user.id != @user.id
  end
end
