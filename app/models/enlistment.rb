class Enlistment < ApplicationRecord
  belongs_to :user
  belongs_to :job

  after_create_commit { broadcast_append_to "enlistments" }

  enum status: %i[interview rejected pending]

  # def initialize
  #   broadcast_append_to "enlistments"
  #   self.status = "pending"
  # end

  def assign_name
    user = User.find(self.user_id)
    job  = Job.find(self.job_id)
    self.name = "#{user.name} applied for #{job.name} at #{Company.find(job.company_id).name}"
  end
end
 