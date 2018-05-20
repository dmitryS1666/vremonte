class User < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def owner_of?(resource)
    resource.user_id == self.id
  end
end
