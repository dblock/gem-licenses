#!/usr/bin/env ruby
# encoding: utf-8
#
# Parse the output of gem-licenses (a list of licenses and the gems that use them)
# and print a YAML file in the New Relic dependency_manifest.yml format 
# (key-value pairs of "gemname-version: license").
#
# Sample input after the __END__ of this source file.

require 'polyglot'
require 'treetop'
require 'gem_licenses.treetop'

p = GemLicensesParser.new
tree = p.parse(DATA.read)

gems = []
tree.elements.each do |section|
  section.gems.elements.each do |gem|
    gems << "  #{gem.gem.name.text_value}-#{gem.gem.version.text_value}: #{section.license_name.text_value}"
  end
end

puts "gems:"
gems.sort.each do |gem|
  puts gem
end
# Placeholder section
puts <<EOD
javascripts:
  foo: GPL
EOD

__END__
New Relic
----------
* newrelic_rpm 3.3.4.beta1 (http://www.github.com/newrelic/rpm) - New Relic Ruby Agent

Perl Artistic (http://www.perl.com/perl/misc/Artistic.html)
----------
* getopt-declare 1.29 (http://www.rubyforge.org/projects/getoptdeclare/) - A regex command-line parsing library.

Apache v2.0
----------
* addressable 2.2.6 (http://addressable.rubyforge.org/) - URI Implementation
* rubygems-bundler 1.0.4 (http://mpapis.github.com/rubygems-bundler) - Stop using bundle exec

BSD (4-clause)
----------
* rdiscount 1.6.8 (http://github.com/rtomayko/rdiscount) - Fast Implementation of Gruber's Markdown in C

Simplified BSD (2-clause)
----------
* debugger 1.2.0 (http://github.com/cldwalker/debugger) - Fast Ruby debugger - base + cli

New BSD (3-clause)
----------
* sqlite3 1.3.5 (http://github.com/luislavena/sqlite3-ruby) - This module allows Ruby programs to interface with the SQLite3 database engine (http://www.sqlite.org)

Ruby
----------
* columnize 0.3.6 (https://github.com/rocky/columnize) - Module to format an Array as an Array of String aligned in columns
* json 1.7.5 (http://flori.github.com/json) - JSON Implementation for Ruby
* thin 1.3.1 (http://code.macournoyer.com/thin/) - A thin and fast web server

Ruby or GPLv2
----------
* eventmachine 0.12.10 (http://rubyeventmachine.com) - Ruby/EventMachine library
* highline 1.6.8 (http://highline.rubyforge.org) - HighLine is a high-level command-line IO library.

Ruby or GPLv3 or GPL v2
----------
* unicorn 4.3.1 (http://unicorn.bogomips.org/) - Rack HTTP server for fast clients and Unix

Ruby or GPLv2 or Perl Artistic
----------
* mime-types 1.19 (http://mime-types.rubyforge.org/) - This library allows for the identification of a file's likely MIME content type

GPLv2 or Artistic-like
----------
* rdoc 3.12 (http://docs.seattlerb.org/rdoc) - RDoc produces HTML and command-line documentation for Ruby projects (License terms: http://docs.seattlerb.org/rdoc/LICENSE_rdoc.html)

MIT
----------
* actionmailer 3.1.8 (http://www.rubyonrails.org) - Email composition, delivery, and receiving framework (part of Rails).
* actionpack 3.1.8 (http://www.rubyonrails.org) - Web-flow and rendering framework putting the VC in MVC (part of Rails).
* activemodel 3.1.8 (http://www.rubyonrails.org) - A toolkit for building modeling frameworks (part of Rails).
* activerecord 3.1.8 (http://www.rubyonrails.org) - Object-relational mapper framework (part of Rails).
* activeresource 3.1.8 (http://www.rubyonrails.org) - REST modeling framework (part of Rails).
* activesupport 3.1.8 (http://www.rubyonrails.org) - A toolkit of support libraries and Ruby core extensions extracted from the Rails framework.
* acts-as-taggable-on 2.1.1 () - Advanced tagging for Rails.
* arel 2.2.3 (http://github.com/rails/arel) - Arel is a SQL AST manager for Ruby
* builder 3.0.3 (http://onestepback.org) - Builders for MarkUp.
* bundler 1.2.0 (http://gembundler.com) - The best way to manage your application's dependencies
* capistrano 2.9.0 (http://github.com/capistrano/capistrano) - Capistrano - Welcome to easy deployment with Ruby over SSH
* coffee-rails 3.1.1 () - Coffee Script adapter for the Rails asset pipeline.
* coffee-script 2.2.0 (http://github.com/josh/ruby-coffee-script) - Ruby CoffeeScript Compiler
* coffee-script-source 1.1.3 (http://jashkenas.github.com/coffee-script/) - The CoffeeScript Compiler
* daemons 1.1.0 (http://daemons.rubyforge.org) - A toolkit to create and control daemons in different ways
* debugger-linecache 1.1.2 (http://github.com/cldwalker/debugger-linecache) - Read file with caching
* debugger-ruby_core_source 1.1.3 (http://github.com/cldwalker/debugger-ruby_core_source) - Provide Ruby core source files
* erubis 2.7.0 (http://www.kuwata-lab.com/erubis/) - a fast and extensible eRuby implementation which supports multi-language
* execjs 1.2.12 (https://github.com/sstephenson/execjs) - Run JavaScript code from Ruby
* fakeweb 1.3.0 (http://github.com/chrisk/fakeweb) - A tool for faking responses to HTTP requests
* gem-licenses 0.1.2 (http://github.com/dblock/gem-licenses) - List all gem licenses.
* haml 3.1.4 (http://haml-lang.com/) - An elegant, structured XHTML/XML templating engine.
* hike 1.2.1 (http://github.com/sstephenson/hike) - Find files in a set of paths
* httparty 0.8.1 (http://httparty.rubyforge.org/) - Makes http fun! Also, makes consuming restful web services dead easy.
* i18n 0.6.1 (http://github.com/svenfuchs/i18n) - New wave Internationalization support for Ruby
* jquery-rails 1.0.19 (http://rubygems.org/gems/jquery-rails) - Use jQuery with Rails 3
* mail 2.3.3 (http://github.com/mikel/mail) - Mail provides a nice Ruby DSL for making, sending and reading emails.
* metaclass 0.0.1 (http://github.com/floehopper/metaclass) - Adds a metaclass method to all Ruby objects
* mocha 0.10.0 (http://mocha.rubyforge.org) - Mocking and stubbing library
* multi_json 1.2.0 (http://github.com/intridea/multi_json) - A gem to provide swappable JSON backends.
* multi_xml 0.4.1 (https://github.com/sferik/multi_xml) - A generic swappable back-end for XML parsing
* mysql2 0.3.11 (http://github.com/brianmario/mysql2) - A simple, fast Mysql library for Ruby, binding to libmysql
* net-scp 1.0.4 (http://net-ssh.rubyforge.org/scp) - A pure Ruby implementation of the SCP client protocol
* net-sftp 2.0.5 (http://net-ssh.rubyforge.org/sftp) - A pure Ruby implementation of the SFTP client protocol
* net-ssh 2.2.1 (http://github.com/net-ssh/net-ssh) - Net::SSH: a pure-Ruby implementation of the SSH2 client protocol.
* net-ssh-gateway 1.1.0 (http://net-ssh.rubyforge.org/gateway) - A simple library to assist in establishing tunneled Net::SSH connections
* nokogiri 1.5.0 (http://nokogiri.org) - Nokogiri (é¸) is an HTML, XML, SAX, and Reader parser
* polyglot 0.3.3 (http://github.com/cjheath/polyglot) - Augment 'require' to load non-Ruby file types
* rack 1.3.6 (http://rack.rubyforge.org) - a modular Ruby webserver interface
* rack-cache 1.2 (https://github.com/rtomayko/rack-cache/) - HTTP Caching for Rack
* rack-mount 0.8.3 (https://github.com/josh/rack-mount) - Stackable dynamic tree based Rack router
* rack-ssl 1.3.2 (https://github.com/josh/rack-ssl) - Force SSL/TLS in your app.
* rack-test 0.6.1 (http://github.com/brynary/rack-test) - Simple testing API built on Rack
* rails 3.1.8 (http://www.rubyonrails.org) - Full-stack web application framework.
* railties 3.1.8 (http://www.rubyonrails.org) - Tools for creating, working with, and running Rails applications.
* rake 0.9.2.2 (http://rake.rubyforge.org) - Ruby based make-like utility.
* riddle 1.5.0 (http://freelancing-god.github.com/riddle/) - An API for Sphinx, written in and for Ruby.
* sass 3.1.11 (http://sass-lang.com/) - A powerful but elegant CSS compiler that makes CSS fun again.
* sass-rails 3.1.5 () - Sass adapter for the Rails asset pipeline.
* shoulda 2.11.3 (http://thoughtbot.com/community/) - Making tests easy on the fingers and eyes
* shoulda-matchers 1.0.0 (http://thoughtbot.com/community/) - Making tests easy on the fingers and eyes
* sprockets 2.0.4 (http://getsprockets.org/) - Rack-based asset packaging system
* thinking-sphinx 2.0.10 (http://freelancing-god.github.com/ts/en/) - ActiveRecord/Rails Sphinx library
* thor 0.14.6 (http://github.com/wycats/thor) - A scripting framework that replaces rake, sake and rubigen
* tilt 1.3.3 (http://github.com/rtomayko/tilt/) - Generic interface to multiple Ruby template engines
* timecop 0.3.5 (http://github.com/jtrupiano/timecop) - A gem providing "time travel" and "time freezing" capabilities, making it dead simple to test time-dependent code.  It provides a unified method to mock Time.now, Date.today, and DateTime.now in a single call.
* treetop 1.4.10 (http://functionalform.blogspot.com) - A Ruby-based text parsing and interpretation DSL
* tzinfo 0.3.33 (http://tzinfo.rubyforge.org/) - Daylight-savings aware timezone library
* uglifier 1.1.0 (http://github.com/lautis/uglifier) - Ruby wrapper for UglifyJS JavaScript compressor
* will_paginate 3.0.2 (https://github.com/mislav/will_paginate/wiki) - Pagination plugin for web frameworks and other apps
* yajl-ruby 0.7.9 (http://github.com/brianmario/yajl-ruby) - Ruby C bindings to the excellent Yajl JSON stream-based parser library.
* yaml_db 0.2.2 (http://github.com/ludicast/yaml_db) - yaml_db allows export/import of database into/from yaml files

LGPL v3 or v2.1
----------
* kgio 2.7.4 (http://bogomips.org/kgio/) - kinder, gentler I/O for Ruby
* raindrops 0.10.0 (http://raindrops.bogomips.org/) - real-time stats for preforking Rack servers
