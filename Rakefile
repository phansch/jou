gem 'rspec', '~>2'
require 'rspec/core/rake_task'

task :default => :spec

desc "Run tests for journal"
RSpec::Core::RakeTask.new do |task|
  task.pattern = "spec/*_spec.rb"
  task.rspec_opts = %w[--color --format documentation --fail-fast]
  task.verbose = false
end