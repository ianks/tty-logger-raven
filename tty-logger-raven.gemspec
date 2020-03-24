lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'tty-logger-raven'
  spec.version = '0.3'
  spec.authors = ['Ian Ker-Seymer']
  spec.email = %w[ian.kerseymer@tryadhawk.com]

  spec.summary = 'Raven for Ruby handler for tty-logger'
  spec.description = 'Raven for Ruby handler for tty-logger'
  spec.homepage = 'https://github.com/ianks/tty-logger-raven'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] =
      'https://github.com/ianks/tty-logger-raven'
    spec.metadata['changelog_uri'] =
      'https://github.com/ianks/tty-logger-raven/blob/master/changelog.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
            'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
      end
    end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'prettier'

  spec.add_dependency 'tty-logger', '~> 0.3'
  spec.add_dependency 'sentry-raven', '~> 3.0'
end
