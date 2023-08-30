class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  validates :email, presence: true, uniqueness: true#, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :cover_letter, length: {minimum: 20, maximum: 255}

  enum tertiary_education: %i[no studying completed]

  has_one_attached :photo
  
  after_create_commit { broadcast_append_to "users"}
  
  after_commit :add_default_photo, on: %i[create update]

  def valid_password?
    return false if self.password.length < 7
    # capitals = 0
    # lowers   = 0
    # numbers  = 0
    # self.password.split('').each{|letter|
    #   capitals += 1 if letter.ord >= 65 && letter.ord <=  97
    #   lowers   += 1 if letter.ord >= 97 && letter.ord <= 122
    #   numbers  += 1 if letter.ord >= 48 && letter.ord <=  57
    # }
    # return false if capitals == 0 || lowers == 0 || numbers == 0
    true
  end

  def photo_thumbnail
    photo.variant(resize_to_limit: [400, 400]).processed
  end

  private 
  def add_default_photo
    return if photo.attached?

    photo.attach(
      io: File.open(Rails.root.join('app','assets','images','default_avatar.jpg')),
      filename: 'default_avatar.jpg',
      content_type: 'image/jpg'
    )
  end

end
