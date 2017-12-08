class Comment < ApplicationRecord
  paginates_per 15
  validates :body, presence: true
  acts_as_paranoid
  resourcify
  
  belongs_to :post
  belongs_to :user
end
