class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }

end
