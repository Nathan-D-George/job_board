class NotifierMailer < ApplicationMailer
  def new_email
    @enlistment = params[:enlistment]
    @user       = User.find(@enlistment.user_id)
    @job        = Job.find(@enlistment.job_id)
    @company    = Company.find(@job.company_id)

    mail(to: 'first@user.com', subject: "You are invited for an interview!")
  end
end
