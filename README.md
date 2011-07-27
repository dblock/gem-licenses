Gem-Licenses
============

Gem-licenses is an attempt to collect license information from project's gems. Similar to [3licenses](http://3licenses.codeplex.com/).

Motivation
==========

The overwhelming majority of 3rd party licenses require the application that uses them to reproduce the license verbatim in an artifact that is installed with the application itself. For instance, the BSD license states the following. 

“Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.”

Are you currently copying individual license.txt files "by hand" or are you including license text in your documentation with copy/paste? This project aims at improving this situation.

Usage
=====

Include in your project. To list licenses try the following Rake task.

    task :licenses do
      Gem.licenses.each do |license, gems| 
        puts "#{license}"
        gems.sort_by { |gem| gem.name }.each do |gem|
          puts "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary}"
        end
      end
    end

Contributing
============

* Fork the project.
* Make your feature addition or bug fix, write tests.
* Commit, do not mess with rakefile, version, or history.
* Make a pull request.

License
=======

This project is licenced under the MIT license.

Copyright
=========

Copyright (c) Daniel Doubrovkine, 2011 by Artsy, Inc.





