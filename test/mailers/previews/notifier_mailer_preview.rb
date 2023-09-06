# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview
  
  def new_email
    enlistment = Enlistment.new
    enlistment.name    = "this_user applied to this_company" 
    enlistment.user_id =  1
    enlistment.job_id  = 2
    enlistment.save
    NotifierMailer.with(enlistment: enlistment).new_email
  end

end
