class UsersController < ApplicationController
  before_action :initialize_function, only: [:show, :edit, :destroy, :edit_password]

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "Account created. Welcome #{user.name}!"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:alert]  = 'Something went wrong'      
      redirect_to new_user_path
    end
  end

  def show
    # debugger
  end

  def edit
    @user = User.find(params[:id].to_i)
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = 'Account successfully updated'
    else
      flash[:alert]  = 'Something went wrong'
    end
    redirect_to show_user_path(id: user.id)
  end

  def delete1
    @user = User.find(params[:id].to_i)
  end

  def delete2
    @user = User.find(params[:id].to_i)
  end

  def destroy
    debugger
    @user.destroy
    session[:user_id] = nil
    flash[:notice]    = 'Deleted User Account'
    redirect_to root_path
  end

  def edit_password
  end

  def change_password
    debugger
  end

  private
  def initialize_function
    @user = User.find(params[:id])
  end

  def user_params
    params.require('user').permit(:name, :email, :password, :password_confirmation, :tertiary_education, :cover_letter)
  end
end
