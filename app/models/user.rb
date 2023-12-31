class User < ApplicationRecord

  has_secure_password

  has_many  :companies
  has_many :friendships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :settings, dependent: :destroy

  has_many :enlistments, dependent: :destroy 
  has_many :jobs, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :user_categories
  has_many :categories, through: :user_categories
  
  has_one :profile, dependent: :destroy

  validates :name, presence: true, length: {minimum: 4, maximum: 30}
  validates :email, presence: true, uniqueness: true #, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  validates :cover_letter, length: { maximum: 255 }

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

  def already_friends_with?(id)
    Friendship.where(user_id: self.id, friend_id: id).present?
  end

  def already_liked?(id)
    Like.where(user_id: self.id, post_id: id).present?
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
