class CompaniesController < ApplicationController
  before_action :logged_in_only, except: [:new, :create, :new_company_user, :create_company_user]
  before_action :initialize_function, only: [:edit, :show,   :delete]
  before_action :company_admin_only,  only: [:edit, :update, :delete]
  $company_id = nil  

  def new
    @company = Company.new
  end

  def create
    company = Company.new(company_params)
    company.user_id = Current.user.id
    if company.save
      flash[:notice] = "Successfully Registered #{company.name}"      
      redirect_to root_path
    else
      flash[:alert]  = "Something went wrong."
      render :new
    end
  end

  def new_company_user
    @user = User.new
  end

  def create_company_user
    user = User.new
    user.name  = params[:user][:name]
    user.email = params[:user][:email]
    user.password              = params[:user][:password]
    user.password_confirmation = params[:user][:password_confirmation]
    if user.save
      session[:user_id] = user.id
      flash[:notice]    = "Admin Account generated"
      redirect_to new_company_path
    else
      flash[:alert] = "Something went wrong"
      render :new_company_user
    end
  end

  def show
    @jobs_list = @company.jobs
    # @first_job = @company.jobs.first
    console
  end

  def list
    @companies = Company.all.order(name: :asc)
  end

  def edit
    redirect_to show_company_path(id: @company.id), alert: "Company Admin Only" if @company.user_id != Current.user.id
    $company_id = params[:id].to_i
  end

  def update
    company = Company.find($company_id)
    if company.update(company_params)
      flash[:notice] = 'Updated Company Information'
      redirect_to show_company_path(id: company.id)
    else
      flash[:alert]  = 'Something went wrong'
      render :edit
    end
  end

  def delete
    @user    = User.find(@company.user_id)
    flash[:notice]    = "Deleted #{ @company.name }"
    session[:user_id] = nil
    @company.destroy
    @user.destroy
    redirect_to root_path
  end

  private

  def company_params
    params.require('company').permit(:name, :website, :description, :logo, :location, :number_employees)
  end

  def initialize_function
    @company = Company.find(params[:id].to_i)
  end

  def company_admin_only
    redirect_to show_company_path(id: @company.id), alert: 'Only the Company Admin can Work Here' if @company.user_id == Current.user.id
  end

end
