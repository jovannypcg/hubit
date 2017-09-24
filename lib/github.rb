require 'httparty'
require 'pry'

# Github API wrapper, which provides useful methods to retrieve
# information from its endpoints, such as public repositories.
class Github
  include HTTParty
  base_uri 'api.github.com'

  def initialize(opts = {})
    @opts = opts
  end

  # Retrieves public repositories information from Github.
  # By default, it returns 100 repositories per request. "since" query
  # parameter can be given as pagination tool.
  #
  # More information:
  # https://developer.github.com/v3/repos/#list-all-public-repositories
  #
  # +since+:: Starting point to retrieve 100 repositories.
  def public_repositories(since: 0)
    query = { query: { since: since } }
    opts = @opts.merge(query)

    response = self.class.get('/repositories', opts).body
    JSON.parse(response)
  end
end
