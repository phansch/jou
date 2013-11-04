gem 'rdoc'
gem 'rspec', '~>2'
require 'bundler'
require 'rake/clean'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'rdoc/task'
include Rake::DSL

Bundler::GemHelper.install_tasks

desc "Run unit tests"

RSpec::Core::RakeTask.new do |task|
  task.pattern = "spec/*_spec.rb"
  task.rspec_opts = %w[--color --format documentation --fail-fast]
  task.verbose = false
end

desc "Run features"
CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty --no-source -x"
  t.fork = false
end

task :default => [:spec,:features]
