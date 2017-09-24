class User < ApplicationRecord
  include Storable

  has_many :repositories, dependent: :destroy

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
end
