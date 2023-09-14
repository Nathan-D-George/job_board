class Setting < ApplicationRecord
  belongs_to :user

  enum theme: %i[light dark]
  
end
