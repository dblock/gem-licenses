require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

lint = RUBY_ENGINE == 'ruby' && Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.3') &&
       Gem.loaded_specs.key?('rubocop')
if lint
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Lint Ruby, Markdown, YAML, and spelling'
  task lint: :rubocop
end

task default: lint ? %i[rubocop spec] : %i[spec]

require 'rake'

Bundler::GemHelper.install_tasks

require 'gem_licenses'
Gem::GemLicenses.install_tasks
