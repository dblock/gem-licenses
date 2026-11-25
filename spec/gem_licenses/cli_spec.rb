# frozen_string_literal: true

require 'spec_helper'
require 'gem-licenses/cli'
require 'csv'
require 'open3'
require 'stringio'
require 'tmpdir'

describe Gem::GemLicenses::CLI do
  let(:out) { StringIO.new }
  let(:err) { StringIO.new }
  let(:cli) { described_class.new(out: out, err: err) }

  before do
    allow(cli).to receive(:bundle_specs).and_return([]) unless RSpec.current_example.metadata[:bundle]
  end

  let(:mit_gem) do
    Gem::Specification.new do |spec|
      spec.name = 'mit-gem'
      spec.version = '1.0.0'
      spec.homepage = 'https://example.com/mit-gem'
      spec.summary = 'An MIT gem.'
    end
  end

  let(:unknown_gem) do
    Gem::Specification.new do |spec|
      spec.name = 'unknown-gem'
      spec.version = '2.0.0'
      spec.homepage = 'https://example.com/unknown-gem'
      spec.summary = 'A gem without a license.'
    end
  end

  context 'with a loaded bundle' do
    before do
      allow(Gem).to receive(:licenses).and_return('unknown' => [unknown_gem], 'MIT' => [mit_gem])
    end

    it 'lists gems grouped by license' do
      expect(cli.run([])).to eq 0
      expect(out.string).to include("MIT\n===\n* mit-gem 1.0.0 (https://example.com/mit-gem) - An MIT gem.\n")
    end

    it 'writes gems and licenses to a CSV file sorted by license' do
      Dir.mktmpdir do |dir|
        filename = File.join(dir, 'licenses.csv')
        expect(cli.run(['--csv', filename])).to eq 0
        expect(CSV.read(filename).map(&:first)).to eq %w[name mit-gem unknown-gem]
        expect(out.string).to include('Written 2 license(s) for 2 project(s): MIT, unknown')
      end
    end

    it 'fails with --strict when a gem has no guessable license' do
      expect(cli.run(['--strict'])).to eq 1
    end
  end

  it 'passes --strict when every license is known' do
    allow(Gem).to receive(:licenses).and_return('MIT' => [mit_gem])
    expect(cli.run(['--strict'])).to eq 0
  end

  it 'shows the version' do
    expect(cli.run(['--version'])).to eq 0
    expect(out.string).to eq "gem-licenses #{Gem::GemLicenses::VERSION}\n"
  end

  it 'shows help' do
    expect(cli.run(['--help'])).to eq 0
    expect(out.string).to include('Usage: gem-licenses [options]', '--gemfile PATH', '--csv FILE', '--strict')
  end

  it 'rejects unknown options' do
    expect(cli.run(['--unknown'])).to eq 2
    expect(err.string).to eq "gem-licenses: invalid option: --unknown.\nRun gem-licenses --help for usage.\n"
  end

  it 'rejects unexpected arguments' do
    expect(cli.run(['licenses.csv'])).to eq 2
    expect(err.string).to start_with "gem-licenses: unexpected argument: licenses.csv.\n"
  end

  it 'fails when the Gemfile does not exist', :bundle do
    Dir.mktmpdir do |dir|
      gemfile = File.join(dir, 'Gemfile')
      expect(cli.run(['--gemfile', gemfile])).to eq 2
      expect(err.string).to start_with "gem-licenses: no Gemfile at #{gemfile}.\n"
    end
  end

  describe 'the gem-licenses executable' do
    let(:exe) { File.expand_path('../../exe/gem-licenses', __dir__) }

    def gem_names(output)
      output.scan(/^\* (\S+) /).flatten.uniq.sort
    end

    it 'lists the gems of the current bundle under bundle exec' do
      stdout, status = Open3.capture2(RbConfig.ruby, exe)
      expect(status).to be_success
      expect(gem_names(stdout)).to include('rake', 'rspec-core')
      expect(gem_names(stdout)).to match_array(Bundler.load.specs.map(&:name).uniq)
    end

    it 'lists only the gems of the Gemfile given with --gemfile' do
      Dir.mktmpdir do |dir|
        gemfile = File.join(dir, 'Gemfile')
        File.write(gemfile, "source 'https://rubygems.org'\ngem 'rake'\n")
        stdout, stderr, status = Bundler.with_unbundled_env do
          Open3.capture3(RbConfig.ruby, exe, '--gemfile', gemfile, chdir: dir)
        end
        expect(status).to be_success, stderr
        expect(gem_names(stdout) - ['bundler']).to eq ['rake']
      end
    end
  end
end
