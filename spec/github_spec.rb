require 'rails_helper'
require 'github'
require 'pry'

describe Github do
  let(:github) { Github.new }

  describe '#public_repositories' do
    it 'retrieves repos correctly' do
      VCR.use_cassette 'public_repositories' do
        repos = github.public_repositories

        expect(repos).to_not be_nil
        expect(repos).to be_a(Array)
        expect(repos.size).to be > 0
      end
    end
  end
end
