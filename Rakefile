require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :lint do
  sh "bundle exec rbprettier --check '**/*.{rb,gemspec}'"
end