class Comment < ApplicationRecord
  belongs_to :request

  validates :body, presence: true
end
