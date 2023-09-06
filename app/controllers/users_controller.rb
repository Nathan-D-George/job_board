class UsersController < ApplicationController
  before_action :logged_in_only, except: [:new, :create]
  before_action :initialize_function, only: [:edit, :edit_password, :destroy, :delete1, :delete2, :show]
  before_action :correct_user_only,   only: [:edit, :edit_password, :destroy, :delete1, :delete2]

  def new
    @user = User.new
  end

  def create
    user = User.new
    user.name  = params[:user][:name]
    user.email = params[:user][:email]
    user.photo = params[:user][:photo] if params[:user][:photo].present?
    user.password = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    user.tertiary_education    = params[:user][:tertiary_education]
    user.cover_letter          = params[:user][:cover_letter]
    if user.save
      flash[:notice] = "Account created. Welcome #{user.name}!"
      session[:user_id] = user.id
      redirect_to new_profile_path
    else
      flash[:alert]  = 'Something went wrong'      
      redirect_to new_user_path
    end
  end

  def show
    @photo = "https://images.unsplash.com/photo-1619472376731-3ca648a34b69?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDE0fENEd3V3WEpBYkV3fHxlbnwwfHx8fHw%3D&auto=format&fit=crop&w=500&q=60"
    @profile = @user.profile if @user.companies.blank?
    redirect_to show_company_path(id: @user.companies.first.id) if @user.companies.present?
  end

  def edit
    @user = User.find(params[:id].to_i)
  end

  def update
    user = User.find(params[:id])
    user.name  = params[:user][:name]
    user.email = params[:user][:email]
    user.photo = params[:user][:photo] if params[:user][:photo].present?
    user.tertiary_education = params[:user][:tertiary_education]
    user.cover_letter       = params[:user][:cover_letter]
    if user.save
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
    @user.destroy
    session[:user_id] = nil
    flash[:notice]    = 'Deleted User Account'
    redirect_to root_path
  end

  def edit_password
  end

  def change_password
    user = Current.user
    if user.authenticate(params[:user][:old_password])
      user.password              = params[:user][:new_password]
      user.password_confirmation = params[:user][:new_password_confirmation]
      if user.password == user.password_confirmation && user.valid_password?
        user.save
        flash[:notice] = "Password Updated"
      else
        flash[:alert]  = "Something went wrong"
      end
    end
    redirect_to edit_user_registration_path(id: user.id)
  end

  private
  def initialize_function
    @user = User.find(params[:id])
  end

  def user_params
    params.require('user').permit(:name, :email, :password, :password_confirmation, :tertiary_education, :cover_letter) 
  end 
end
