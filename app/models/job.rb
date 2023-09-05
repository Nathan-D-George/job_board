class Job < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 20, maximum: 400}
  
  has_one_attached :photo

  after_create_commit { broadcast_append_to "jobs" }
  after_commit :add_default_job_photo

  private

  def add_default_job_photo
    return if photo.attached?

    photo.attach(
      io: File.open(Rails.root.join('app','assets','images','default_job_logo.avif')),
      filename: 'default_job_logo.avif',
      content_type: 'image/avif'
    )

  end 

end
