class Request < ApplicationRecord
  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true, length: { minimum: 2 }
  validates :owner_id, presence: true
end
