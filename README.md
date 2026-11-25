# Gem-Licenses

[![Test](https://github.com/dblock/gem-licenses/actions/workflows/test.yml/badge.svg)](https://github.com/dblock/gem-licenses/actions/workflows/test.yml)

Gem-licenses is an attempt to collect license information from a project's gems. Similar to [3licenses](https://github.com/dblock/3licenses).

## Motivation

The overwhelming majority of third-party licenses require the application that uses them to reproduce the license verbatim in an artifact that is installed with the application itself. For instance, the BSD license states the following.

> _“Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.”_

Are you currently copying individual `license.txt` files "by hand" or are you including license text in your documentation with copy/paste? This project aims at improving this situation.

## Usage

Include gem-licenses in your project's Gemfile.

```ruby
group :development, :test do
  gem 'gem-licenses'
end
```

Rails applications load the Rake tasks automatically. In other projects, load them in your `Rakefile`. This makes the tasks available each time Rake runs and doesn't copy any files into your project.

```ruby
require 'rake'
require 'gem-licenses'
Gem::GemLicenses.install_tasks
```

To list licenses try the following Rake task.

```shell
rake gem:licenses
```

To write a CSV file of gems and licenses.

```shell
rake gem:licenses:csv['licenses.csv']
```

To write a CSV file of gems, licenses, and the copyright lines found in each gem's license, notice, and readme files.

```shell
rake gem:licenses:copyrights:csv['copyrights.csv']
```

### Command Line

The `gem-licenses` command reports on a project's bundle without changing its `Rakefile`. Run it under `bundle exec` when gem-licenses is in the Gemfile, or install the gem and point it at a project.

```shell
bundle exec gem-licenses
gem-licenses --gemfile path/to/Gemfile
gem-licenses --csv licenses.csv
```

Without `--gemfile`, it reads the bundle that `BUNDLE_GEMFILE` or the `Gemfile` in the current directory describes, whose gems must be installed. Pass `--strict` to exit with status 1 when a gem has no guessable license, for example in CI. Run `gem-licenses --help` for all options.

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md), [CHANGELOG](CHANGELOG.md), and [RELEASING](RELEASING.md).

## License

This project is licensed under the MIT license, see [LICENSE](LICENSE) for details.

## Copyright

Copyright (c) Daniel Doubrovkine, 2011-2016, Artsy, Inc.
