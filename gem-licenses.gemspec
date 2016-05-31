$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'gem-licenses/version'

Gem::Specification.new do |s|
  s.name = 'gem-licenses'
  s.version = Gem::GemLicenses::VERSION
  s.authors = ['Daniel Doubrovkine']
  s.email = 'dblock@dblock.org'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/dblock/gem-licenses'
  s.licenses = ['MIT']
  s.summary = 'Attempts to figure out what licenses various gems use.'
end
