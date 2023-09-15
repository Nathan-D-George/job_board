class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :cv
  has_many_attached :academic_files 

  enum level: %i[Bachelor BachelorOfScience Diploma Honours HigherCertificate Masters PhD]
  enum institution: %i[SU UFS UCT UP UJ Wits NMU UKZN NWU]

  def self.qualification_options
    arr = ["","Law (LLb)", "Law (BA)","Accounting (CA)", "Accounting (Bookeeping)", "Engineering (Civil)", "Engineering (Electronics)",
           "Engineering (Industrial)","Engineering (Mechatronics)","Engineering (Mechanical)","Engineering (Process)", "Physics and Applied Maths",
           "Physics and Chemistry", "Physics and Engineering Subjects", "Physics and Nanotechnology", "Physics and Quantam Theory",
           "Psychiatry","Psychology","Computer Science (Electronics)", "Computer Science(Maths)", "Computer Science (Applied Maths)" "Agriculture", "Veterinary Science"]
  end 

  def self.institution_options 
    arr = ["", "SU", "UFS", "UCT", "UP", "UJ", "Wits","NMU", "UKZN", "NWU"] 
  end 

  def self.level_options 
    arr = ["","Bachelor", "BachelorOfScience", "Diploma", "Honours", "HigherCertificate", "Masters", "PhD"] 
  end 
end 
 