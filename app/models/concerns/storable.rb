module Storable
  extend ActiveSupport::Concern
  included do
    validates :gh_id, uniqueness: true
  end

  # Stores the current storable object only if it does not exist in
  # database, otherwise the existing record is returned.
  def store
    already_exists = self.class.exists?(gh_id: self.gh_id)

    already_exists ? self.class.find_by(gh_id: self.gh_id)
                   : self.class.create(self.attributes)
  end
end
