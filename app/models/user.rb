class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :cover_letter, length: {minimum: 20, maximum: 255}

  enum tertiary_education: %i[no studying completed]
end
