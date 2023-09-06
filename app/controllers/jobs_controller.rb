class JobsController < ApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :initialize_variables, only: [:edit, :destroy, :show]
  before_action :company_admin_only, only:   [:edit, :destroy]
  $company_id = nil

  def new
    @job = Job.new
    $company_id = params[:id].to_i
    @company    = Company.find($company_id)
    @categories = Category.all
    console
  end

  def create
    job = Job.new
    job.name        = params[:job][:name]
    job.description = params[:job][:description]
    job.required_experience = params[:job][:experience]
    job.salary      = params[:job][:salary]
    job.company_id  = $company_id
    if job.save 
      flash[:notice] = 'Job Post Created'
      redirect_to list_jobs_path
    else
      flash[:alert]  = 'Something went wrong'
      render :new
    end
  end

  def show
    @enlistments = Enlistment.where(job_id: @job.id, user_id: Current.user.id).all
  end

  def list
    if Current.user.companies.blank?
      @jobs = Job.all.order(id: :desc) 
    else
      company = Current.user.companies.first
      @jobs   = Job.where(company_id: company.id).all 
    end
  end

  def edit
  end

  def update
    job = Job.find(params[:id])
    job.name        = params[:job][:name]
    job.description = params[:job][:description]
    job.required_experience  = params[:job][:experience] if params[:job][:experience].present?
    job.salary      = params[:job][:salary]
    if job.save
      flash[:notice] = "Job Post Updated"
      redirect_to show_job_path(id: job.id)
    else  
      flash[:alert]  = "Something went wrong"
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Job successfully deleted"
    @job.destroy
    redirect_to show_company_path(id: company.id )
  end

   private

   def company_admin_only
    redirect_to show_job_path(id: @job.id), alert: "Company admin priveledges only !" if Current.user.id != @company.user_id
   end

   def initialize_variables
    @job     = Job.find(params[:id])
    @company = Company.find(@job.company_id)
   end
end
