require 'rubygems'
require 'bundler'

Bundler.setup(:default, :development)

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: [:rubocop, :spec]

require 'rake'

Bundler::GemHelper.install_tasks

require 'gem_licenses'

task :licenses do
  Gem.licenses.each do |license, gems|
    puts "#{license}"
    puts '=' * license.length
    gems.sort_by(&:name).each do |gem|
      puts "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary.strip}"
      puts gem.full_gem_path
    end
    puts ''
  end
end
