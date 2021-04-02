# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'concourse/version'
require 'date'

files = %w[
  bin
  lib
  CODE_OF_CONDUCT.md
  concourse.rb.gemspec
  Gemfile
  LICENSE.txt
  Rakefile
  README.md
]

Gem::Specification.new do |spec|
  spec.name = 'concourse.rb'
  spec.version = Concourse::VERSION
  spec.authors = ['Toby Clemson']
  spec.email = ['tobyclemson@gmail.com']

  spec.summary = 'A Ruby SDK for the Concourse CI API.'
  spec.description = 'A Ruby SDK for the Concourse CI API.'
  spec.homepage = 'https://github.com/infrablocks/concourse.rb'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(/^(#{files.map { |g| Regexp.escape(g) }.join('|')})/)
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_dependency 'dry-schema', '~> 0.5'
  spec.add_dependency 'excon', '~> 0.72'
  spec.add_dependency 'semantic', '~> 1.5'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'faker', '~> 2.15'
  spec.add_development_dependency 'gem-release', '~> 2.0'
  spec.add_development_dependency 'jwt', '~> 2.2'
  spec.add_development_dependency 'openssl', '~> 2.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rake_circle_ci', '~> 0.9'
  spec.add_development_dependency 'rake_github', '~> 0.5'
  spec.add_development_dependency 'rake_gpg', '~> 0.12'
  spec.add_development_dependency 'rake_ssh', '~> 0.4'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'rubocop-rake', '~> 0.5'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.2'
end
