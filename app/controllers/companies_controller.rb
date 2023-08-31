class CompaniesController < ApplicationController
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
    @company = Company.find(params[:id].to_i)
  end

  def list
    @companies = Company.all.order(name: :asc)
  end

  def edit
    @company = Company.find(params[:id].to_i)
    $company_id = params[:id].to_i
  end

  def update
    company = Company.find($company_id)
    # debugger
    if company.update(company_params)
      flash[:notice] = 'Updated Company Information'
      redirect_to show_company_path(id: company.id)
    else
      flash[:alert]  = 'Something went wrong'
      render :edit
    end
  end

  def delete
    @company = Company.find(params[:id].to_i)
  end

  def search
  end

  def results
  end

  private
  def company_params
    params.require('company').permit(:name, :website, :description, :logo, :location, :number_employees)
  end
end
