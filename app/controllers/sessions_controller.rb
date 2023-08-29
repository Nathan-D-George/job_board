class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.where(email: params[:user][:email]).first
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      flash[:notice]    = "Successfully signed in #{user.name}"
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice]    = 'You are logged out'
    redirect_to root_path
  end
end
