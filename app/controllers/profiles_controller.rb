class ProfilesController < ApplicationController
  before_action :logged_in_only
  # before_action :initialize_function, only: 
  # before_action :correct_user_only, 

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new
    profile.user_id = Current.user.id
    profile.level          = params[:profile][:level]
    profile.qualification  = params[:profile][:qualification]
    profile.institution    = params[:profile][:institution]
    profile.cv             = params[:profile][:cv] if params[:profile][:cv].present?
    profile.academic_files = params[:profile][:academic_docs] if params[:profile][:academic_docs].present?
    profile.start_date     = params[:profile][:start_date].to_date
    profile.end_date       = params[:profile][:end_date].to_date
    if profile.save
      flash[:notice] = 'Profile created'
      redirect_to show_user_path(id: Current.user.id)
    else
      flash[:alert]  = 'Something went wrong'
    end
  end

  def edit
    @profile = Profile.find(params[:id].to_i)
    @user    = @profile.user
  end

  def update
    profile = Profile.find(params[:id].to_i)
    profile.qualification  = params[:profile][:qualification] if params[:profile][:qualification].present?
    profile.institution    = params[:profile][:institution]   if params[:profile][:institution].present?
    profile.cv             = params[:profile][:cv]            if params[:profile][:cv].present?
    profile.academic_files = params[:profile][:academic_docs] if params[:profile][:academic_docs].present?
    profile.start_date     = params[:profile][:start_date].to_date
    profile.end_date       = params[:profile][:end_date].to_date
    if profile.save
      flash[:notice] = 'Profile Updated'
      redirect_to show_user_path(id: Current.user.id)
    else
      flash[:alert]  = 'Something went wrong'
      render :edit
    end
  end

  private 

  def initialize_function
    @user = User.find(params[:id])
  end
end
