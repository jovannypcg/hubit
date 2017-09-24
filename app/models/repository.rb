class Repository < ApplicationRecord
  belongs_to :user

  validates :gh_id, uniqueness: true

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

  # Stores the current repository only if it does not exist in
  # database, otherwise the existing record is returned.
  def store
    already_exists = Repository.exists?(gh_id: self.gh_id)
    already_exists ? Repository.find_by(gh_id: self.gh_id)
                   : self.class.create(self.attributes)
  end
end
