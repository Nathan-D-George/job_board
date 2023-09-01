class JobsController < ApplicationController
  $company_id = nil

  def new
    @job = Job.new
    $company_id = params[:id].to_i
    @company = Company.find($company_id)
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
      redirect_to show_job_path(id: job.id)
    else
      flash[:alert]  = 'Something went wrong'
      render :new
    end
  end

  def show
    @job = Job.find(params[:id].to_i)
    @company = Company.find(@job.company_id)
  end

  def list
  end

  def edit
    @job = Job.find(params[:id])
    @company = Company.find(@job.company_id)
  end

  def update
  end

  def destroy
  end
end
