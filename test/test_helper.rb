ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Load fixtures in dependency order so foreign keys resolve (users -> posts -> comments/ratings, etc.)
    fixtures :users, :skills, :posts, :post_skills, :comments, :ratings, :friendships

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

