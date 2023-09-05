class EnlistmentsController < ApplicationController
  before_action :logged_in_only

  def create
    job        = Job.find(params[:job_id])
    company    = Company.find(job.company_id) 
    enlistment = Enlistment.new(user_id: Current.user.id, job_id: params[:job_id].to_i)
    enlistment.assign_name
    if enlistment.save
      flash.now[:notice] = "You've applied to #{company.name} for #{job.name}"
    else
      flash.now[:alert]  = "Something went wrong"
    end
  end

  def list
    @enlistments = Enlistment.where(user_id: Current.user.id).all
  end

  def destroy
    @enlistment = Enlistment.find(params[:id])
    job = Job.find(@enlistment.job_id)
    @enlistment.destroy
    flash[:notice] = "Cancelled application for #{job.name}"
    redirect_to show_job_path(id: job.id)
  end

end
