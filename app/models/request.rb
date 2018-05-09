class Request < ApplicationRecord
  has_many :comments

  validates :title, presence: true, length: { minimum: 10 }
  validates :body, presence: true, length: { minimum: 2 }
  validates :owner_id, presence: true
end
