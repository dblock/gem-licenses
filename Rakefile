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

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec

require 'gem_licenses'

task :licenses do
  Gem.licenses.each do |license, gems|
    puts "#{license}"
    puts "=" * license.length
    gems.sort_by { |gem| gem.name }.each do |gem|
      puts "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary.strip}"
      puts gem.full_gem_path
    end
    puts ""
  end
end

