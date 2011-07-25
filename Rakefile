require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require 'rake'
require 'rspec/core/rake_task'

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "gem-licenses"
  gem.homepage = "http://github.com/dblock/gem-licenses"
  gem.license = "MIT"
  gem.summary = "List all gem licenses."
  gem.description = "Attempts to figure out what licenses various gems use."
  gem.email = "dblock@dblock.org"
  gem.authors = [ "Daniel Doubrovkine" ]
end

Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

require 'gem_licenses.rb'

task :licenses do
  Gem.licenses.each do |license, gems| 
    puts "#{license}"
    gems.each do |gem|
      puts " #{gem.name} (#{gem.full_gem_path})"
    end
  end
end

