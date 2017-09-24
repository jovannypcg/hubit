class Repository < ApplicationRecord
  include Storable

  belongs_to :user

  # Converts a hash of form:
  #   { "id": 123, "name": "public_repo", ... }
  #
  # into a storable Repository object.
  #
  # +repo+:: Hash representing a repository.
  def self.parse(repo)
    Repository.new(
        gh_id: repo['id'],
        name: repo['name'],
        full_name: repo['full_name'],
        url: repo['html_url'])
  end
end
