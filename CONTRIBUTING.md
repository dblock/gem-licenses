# Contributing to Gem-Licenses

This project is work of [many contributors](https://github.com/dblock/gem-licenses/graphs/contributors). You're encouraged to submit [pull requests](https://github.com/dblock/gem-licenses/pulls), [propose features and discuss issues](https://github.com/dblock/gem-licenses/issues).

In the examples below, substitute your GitHub username for `contributor` in URLs.

## Fork the Project

Fork the [project on GitHub](https://github.com/dblock/gem-licenses) and check out your copy.

```shell
git clone https://github.com/contributor/gem-licenses.git
cd gem-licenses
git remote add upstream https://github.com/dblock/gem-licenses.git
```

## Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```shell
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

## Bundle Install and Test

Ensure that you can build the project and run tests.

```shell
bundle install
bundle exec rake
```

`bundle exec rake` runs RuboCop and the specs. RuboCop also checks Ruby examples in Markdown, YAML, and spelling; add reviewed project vocabulary to [.spellcheck.txt](.spellcheck.txt). Run `bundle exec rake lint` to lint only. The linters install only on MRI Ruby 3.3 and newer; on older Rubies `rake` runs only the specs.

## Write Tests

Try to write a test that reproduces the problem you're trying to fix or describes a feature that you want to build. Add to [spec](spec).

We definitely appreciate pull requests that highlight or reproduce a problem, even without a fix.

## Write Code

Implement your feature or bug fix.

Make sure that `bundle exec rake` completes without errors.

## Write Documentation

Document any external behavior in the [README](README.md).

## Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md) under *Next*. Make it look like every other line, including your name and link to your GitHub account.

## Push

```shell
git push origin my-feature-branch
```

## Make a Pull Request

Go to https://github.com/contributor/gem-licenses and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within a few days.

## Update CHANGELOG Again

Update the [CHANGELOG](CHANGELOG.md) with the pull request number. A typical entry looks as follows.

```markdown
* [#123](https://github.com/dblock/gem-licenses/pull/123): Reticulated splines - [@contributor](https://github.com/contributor).
```

Amend your previous commit and force push the changes.

```shell
git commit --amend
git push origin my-feature-branch -f
```

## Rebase

If you've been working on a change for a while, rebase with upstream/master.

```shell
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

## Check on Your Pull Request

Go back to your pull request after a few minutes and see whether it passed muster with GitHub Actions. Everything should look green, otherwise fix issues and amend your commit as described above.

## Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

## Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
