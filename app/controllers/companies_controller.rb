class CompaniesController < ApplicationController
  before_action :logged_in_only, except: [:new, :new_company_user, :create_company_user]
  before_action :initialize_function, only: [:edit, :update, :delete, :show]
  before_action :company_admin_only,  only: [:edit, :update, :delete]
  $company_id = nil  

  def new
    @company = Company.new
    @categories = []
    categories  = Category.all.order(name: :asc)
    categories.each {|category|
      @categories.append(category.name)
    }
  end

  def create 
    company = Company.new   
    company.name        = params[:company][:name]
    company.website     = params[:company][:website]
    company.description = params[:company][:description]
    company.logo        = params[:company][:logo]
    company.location    = params[:company][:location]
    company.number_employees = params[:company][:number_employees]
    company.user_id = Current.user.id
    categories      = params[:company][:categories]
    if company.save
      categories.each{|category|
        CompanyCategory.create(company_id: company.id, category_id: Category.where(name: category).first.id) if category.present?
      }
      notification = Notification.new
      notification.new_company_notification(company.name)
      notification.save
      flash[:notice] = "Successfully Registered #{company.name}"      
      redirect_to root_path
    else
      debugger
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
    if Current.user.companies.present?
      @enlistments = []
      # company      = Current.user.companies.first
      jobs         = Job.where(company_id: @company.id).all
      jobs.each {|job|
        enlistments = Enlistment.where(job_id: job.id).all  #if Enlistment.where(job_id: job.id).present?
        enlistments.each{|enlistment|
          @enlistments.append(enlistment)
        }
      }
    else
      @jobs_list  = @company.jobs
      if Current.user.already_friends_with?(@company.user_id)
        @friendship = Friendship.where(user_id: Current.user.id, friend_id: @company.user_id).first
      else
        @friendship = Friendship.new
      end
    end
    @categories = @company.categories
  end

  def list
    @companies = Company.all.order(name: :asc).paginate(page: params[:page], per_page: 6)
  end

  def edit
    redirect_to show_company_path(id: @company.id), alert: "Company Admin Only" if @company.user_id != Current.user.id
    $company_id = params[:id].to_i
    @categories = []
    categories  = Category.all.order(name: :asc)
    categories.each{|category|
      @categories.append(category.name)
    }
  end

  def update
    company             = Company.find($company_id)
    company.name        = params[:company][:name]
    company.website     = params[:company][:website]
    company.description = params[:company][:description]
    company.logo        = params[:company][:logo] if params[:company][:logo].present?
    company.location    = params[:company][:location]
    company.number_employees = params[:company][:number_employees]
    categories = params[:company][:categories]
    if company.save
      if categories.length > 1
        categories.each {|category|
          if category.present?
            CompanyCategory.create(company_id: company.id, category_id: Category.where(name: category).first.id) if CompanyCategory.where(company_id: company.id, category_id: Category.where(name: category).first.id).blank?
          end
        }
      end
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
    #params.require('company').permit(:name, :website, :description, :logo, :location, :number_employees)
  end

  def initialize_function
    @company = Company.find(params[:id].to_i)
  end

  def company_admin_only
    redirect_to show_company_path(id: @company.id), alert: 'Only the Company Admin can Work Here' if @company.user_id != Current.user.id
  end

end
