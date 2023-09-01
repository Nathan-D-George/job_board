class Job < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, length: {minimum: 5}
  validates :description, presence: true, length: {minimum: 20, maximum: 400}
  
end
