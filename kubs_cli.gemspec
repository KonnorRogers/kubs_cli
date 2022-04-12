# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kubs_cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'kubs_cli'
  spec.version       = KubsCLI::VERSION
  spec.authors       = ['paramagicdev']
  spec.email         = ['konnor5456@gmail.com']

  spec.summary       = 'Konnor\'s Ubuntu Based Setup & CLI'
  spec.homepage      = 'https://github.com/ParamagicDev/kubs_cli'
  spec.license       = 'MIT'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ParamagicDev/kubs_cli'
  spec.metadata['changelog_uri'] = 'https://github.com/ParamagicDev/kubs_cli/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'guard', '~> 2.15'
  spec.add_development_dependency 'guard-rspec', '~> 4.0'
  spec.add_development_dependency 'pry', '~> 0.12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_runtime_dependency 'rake', '~> 13.0'
  spec.add_runtime_dependency 'thor', '~> 0.20'
end
