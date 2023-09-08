class Notification < ApplicationRecord

  after_create_commit { broadcast_append_to "notifications" }

  enum kind: %i[new_job update_job new_company new_user]

  def new_job_notification(name, company)
    self.kind = "new_job"
    self.name = "New job post - #{name} at #{company.name}"
  end

  def update_job_notification(name, company)
    self.kind = "update_job"
    self.name = "Update job - #{name} at #{company} has been updated"
  end

  def new_company_notification(name)
    self.kind = "new_company"
    self.name = "New Company - #{name} has Joined Job_Board"
  end

  def new_user_notification(name)
    self.kind = "new_user"
    self.name = "New user - #{name} has joined Job_Board"
  end

end
