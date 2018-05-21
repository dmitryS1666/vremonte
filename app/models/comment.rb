class Comment < ApplicationRecord
  belongs_to :request
  belongs_to :user

  validates :body, presence: true
end
