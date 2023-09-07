class Company < ApplicationRecord
  belongs_to :user 
  has_many :jobs

  has_many :company_categories
  has_many :categories, through: :company_categories

  after_create_commit { broadcast_append_to "companies" }
  after_commit :add_default_logo
  has_one_attached :logo

  enum location: %i[Bloemfontein Cape_Town Pretoria Johannesburg Port_Elizabeth Kimberley Durban Potchefstroom]

  validates :name, presence: true, length: {minimum: 3, maximum:50}
  validates :description, presence: true, length: {minimum:10, maximum: 4000}

  def self.location_options
    locations = ['Bloemfontein','Cape_Town','Pretoria','Johannesburg','Port_Elizabeth', 'Kimberley','Durban','Potchefstroom']
  end

  private
  def add_default_logo
    return if logo.attached?

    logo.attach(
      io: File.open(Rails.root.join('app','assets','images','default_logo_2.avif')),
      filename: 'default_logo_2.avif',
      content_type: 'image/avif'
    )
  end

end
