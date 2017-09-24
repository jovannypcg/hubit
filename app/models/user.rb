class User < ApplicationRecord
  has_many :repositories, dependent: :destroy

  validates :username, uniqueness: true

  # Converts a hash of form:
  #   { "id": 1, "login": "ror", ... }
  #
  # into a storable User object.
  #
  # +user+:: Hash representing a user.
  def self.parse(user)
    User.new(
        username: user['login'],
        gh_id: user['id'],
        avatar: user['avatar_url'],
        url: user['html_url'])
  end

  # Stores the current user only if it does not exist in
  # database, otherwise the existing record is returned.
  def store
    already_exists = User.exists?(username: self.username)

    already_exists ? User.find_by(username: self.username)
                   : self.class.create(self.attributes)
  end
end
