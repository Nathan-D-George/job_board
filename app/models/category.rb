class Category < ApplicationRecord
  has_many :job_categories
  has_many :jobs, through: :job_categories

  has_many :company_categories
  has_many :companies, through: :company_categories

  has_many :user_categories
  has_many :users, through: :user_categories

  validates :name, presence: true, length:{ minimum: 3, maximum:25 }
  validates_uniqueness_of :name

  def self.list_options
    array = []
    Category.all.order(name: :asc).each{|category|
      array.append(category.name)
    }
    array
  end
end
