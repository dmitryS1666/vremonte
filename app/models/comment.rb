class Comment < ApplicationRecord
  belongs_to :request

  validates :body, :request_id, presence: true
end
