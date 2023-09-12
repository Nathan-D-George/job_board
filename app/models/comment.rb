class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create_commit { broadcast_append_to "comments" }
  
end
