class User < ApplicationRecord
  has_many :repositories, dependent: :destroy

  validates :username, uniqueness: true
end
