Gem-Licenses
============

[![Build Status](https://travis-ci.org/dblock/gem-licenses.svg)](https://travis-ci.org/dblock/gem-licenses)

Gem-licenses is an attempt to collect license information from project's gems. Similar to [3licenses](https://github.com/dblock/3licenses).

Motivation
==========

The overwhelming majority of 3rd party licenses require the application that uses them to reproduce the license verbatim in an artifact that is installed with the application itself. For instance, the BSD license states the following.

_“Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.”_

Are you currently copying individual license.txt files "by hand" or are you including license text in your documentation with copy/paste? This project aims at improving this situation.

Usage
=====

Include gem-licenses in your project's Gemfile.

```ruby
group :development, :test do
  gem 'gem-licenses'
end
```

Install Rake tasks from Rakefile.

```ruby
require 'gem-licenses'
Gem::GemLicenses.install_tasks
```

To list licenses try the following Rake task.

```shell
rake gem:licenses
```

To write a CSV file of gems + licenses.

```shell
rake gem:licenses:csv['licenses.csv']
```

Contributing
============

See [CONTRIBUTING](CONTRIBUTING.md).

License
=======

This project is licenced under the MIT license, see [LICENSE](LICENSE) for details.

Copyright
=========

Copyright (c) Daniel Doubrovkine, 2011-2016, Artsy, Inc.
