class EnlistmentsController < ApplicationController
  before_action :logged_in_only
  before_action :company_admin_only,  only: [:invite, :reject, :reconsider]

  def create
    job        = Job.find(params[:job_id])
    company    = Company.find(job.company_id)
    enlistment = Enlistment.new(user_id: Current.user.id, job_id: params[:job_id].to_i)
    enlistmet.enlistment_date = Date.today
    enlistment.assign_name
    if enlistment.save
      flash[:notice] = "You've applied to #{company.name} for #{job.name}"
      redirect_to show_job_path(id: job.id)
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

  def review
    @enlistment = Enlistment.find(params[:id])
    @applicant  = User.find(@enlistment.user_id)
    @job        = Job.find(@enlistment.job_id)
  end

  def invite
    enlistment = Enlistment.find(params[:id])
    user = User.find(enlistment.user_id)
    enlistment.status = "interview"
    if enlistment.save
      flash[:notice] = "Sent interview invite to #{user.name}"
      NotifierMailer.with(enlistment: enlistment).new_email.deliver_now
    else
      flash[:alert]  = "Something went wrong"
    end
    redirect_to review_application_path(id: enlistment.id)
  end

  def reject
    enlistment = Enlistment.find(params[:id])
    enlistment.status = "rejected"
    if enlistment.save
      flash[:notice] = "Rejected application"
    else
      flash[:alert]  = "Something went wrong"
    end
    redirect_to review_application_path(id: enlistment.id)
  end

  def reconsider
    enlistment = Enlistment.find(params[:id])
    enlistment.status = "pending"
    if enlistment.save
      flash[:notice] = "Enlistment status set to pending"
    else
      flash[:alert]  = "Something went wrong"
    end
    redirect_to review_application_path(id: enlistment.id)
  end

  private

  def company_admin_only
    enlistment = Enlistment.find(params[:id])
    job        = Job.find(enlistment.job_id)
    company    = Company.find(job.company_id)
    redirect_to root_path, alert: 'Company Admins Only !' if Current.user.id != company.user_id
  end
end
