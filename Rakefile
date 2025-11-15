require 'rake'
require 'rake/testtask'

# Define a Rake task for running tests
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'spec/**/*_spec.rb'
end

# Define a default task
task default: :test

# Additional tasks can be defined here as needed
