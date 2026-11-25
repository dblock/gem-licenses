#### 0.2.3 (Next)

* [#25](https://github.com/dblock/gem-licenses/pull/25): Replace Travis CI with GitHub Actions testing Ruby 2.7 through 4.0, and make the license normalization spec independent of installed gems - [@dblock](https://github.com/dblock).
* [#26](https://github.com/dblock/gem-licenses/pull/26): Lint Ruby, Markdown, YAML, and spelling with current RuboCop, rubocop-md, rubocop-prose, rubocop-spellcheck, and rubocop-yaml in a separate Lint workflow, and clean up documentation - [@dblock](https://github.com/dblock).
* [#27](https://github.com/dblock/gem-licenses/pull/27): Run CI pushes only on the default branch, cancel superseded pull request runs, and bound test job times - [@dblock](https://github.com/dblock).
* [#29](https://github.com/dblock/gem-licenses/pull/29): Release with ruby-gem-release through a manually dispatched GitHub Actions workflow and RubyGems Trusted Publishing - [@dblock](https://github.com/dblock).
* [#30](https://github.com/dblock/gem-licenses/pull/30): Test the Rake tasks, and fail with a usage message when `gem:licenses:csv` has no filename - [@dblock](https://github.com/dblock).
* [#31](https://github.com/dblock/gem-licenses/pull/31): Load the Rake tasks automatically in Rails applications, load them only once, and clarify loading them from a `Rakefile` - [@olleolleolle](https://github.com/olleolleolle), [@dblock](https://github.com/dblock).
* [#32](https://github.com/dblock/gem-licenses/pull/32): Find licenses named in Markdown headings such as `LICENSE.md`, match "same terms of", skip references without a license name, and warn about unreadable files, carried from [newrelic/gem-licenses](https://github.com/newrelic/gem-licenses) - [@olleolleolle](https://github.com/olleolleolle), [@dblock](https://github.com/dblock).
* Your contribution here.

#### 0.2.2 (2/16/2018)

* [#18](https://github.com/dblock/gem-licenses/pull/18): Make order of rake gem:licenses deterministic - [@edennis](https://github.com/edennis).

#### 0.2.1 (5/31/2016)

* [#10](https://github.com/dblock/gem-licenses/pull/10): Rename class (from `Gem::Licenses` to `Gem::GemLicenses`) in order to avoid conflict with RubyGems 2.5 - [@caiosba](https://github.com/caiosba).

#### 0.2.0 (7/17/2015)

* [#6](https://github.com/dblock/gem-licenses/pull/6): Use HTTPS for rubygems.org - [@O-I](https://github.com/O-I).
* [#4](https://github.com/dblock/gem-licenses/pull/4): Try to match file contents to known, common licenses - [@joeyAghion](https://github.com/joeyAghion).
* Added `gem:licenses` Rake task - [@dblock](https://github.com/dblock).
* Attempt to normalize license name - [@dblock](https://github.com/dblock).
* Install Rake tasks via `Gem::Licenses.install_tasks` - [@dblock](https://github.com/dblock).

#### 0.1.2 (7/27/2011)

* Initial public release - [@dblock](https://github.com/dblock).
