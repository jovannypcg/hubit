require 'pry'
require 'github'

class PublicRepositoriesDownloadJob < ApplicationJob
  queue_as :default

  def perform(since: 0, client: Github.new)
    repos = client.public_repositories(since: since)

    repos.each do |repo|
      owner = repo['owner']
      user = User.parse(owner).store

      repo = Repository.parse(repo)
      repo.user_id = user.id

      repo.store
    end
  end
end
