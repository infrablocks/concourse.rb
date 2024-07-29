# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage :branch
  minimum_coverage line: 97.6, branch: 100
end

require 'bundler/setup'

require 'concourse'

require 'faker'

Dir[File.join(__dir__, 'support', '**', '*.rb')]
  .each { |f| require f }

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = '.rspec_status'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
