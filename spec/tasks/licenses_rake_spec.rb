# frozen_string_literal: true

require 'spec_helper'
require 'csv'
require 'rake'
require 'tmpdir'

describe 'gem:licenses Rake tasks' do
  let(:mit_gem) do
    Gem::Specification.new do |spec|
      spec.name = 'mit-gem'
      spec.version = '1.0.0'
      spec.homepage = 'https://example.com/mit-gem'
      spec.summary = ' An MIT gem. '
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

  before do
    Rake.application = Rake::Application.new
    load File.expand_path('../../tasks/licenses.rake', __dir__)
    allow(Gem).to receive(:licenses).and_return('MIT' => [mit_gem], 'unknown' => [unknown_gem])
  end

  after do
    Rake.application = Rake::Application.new
  end

  describe 'gem:licenses' do
    it 'lists gems grouped by license' do
      expect { Rake::Task['gem:licenses'].invoke }.to output(
        a_string_including("MIT\n===\n* mit-gem 1.0.0 (https://example.com/mit-gem) - An MIT gem.\n")
      ).to_stdout
    end
  end

  describe 'gem:licenses:csv' do
    it 'writes gems and licenses to the CSV file' do
      Dir.mktmpdir do |dir|
        filename = File.join(dir, 'licenses.csv')
        expect { Rake::Task['gem:licenses:csv'].invoke(filename) }.to output(
          a_string_including('Written 2 license(s) for 2 project(s): MIT, unknown')
        ).to_stdout
        expect(CSV.read(filename)).to eq [
          %w[name version homepage summary license],
          ['mit-gem', '1.0.0', 'https://example.com/mit-gem', 'An MIT gem.', 'MIT'],
          ['unknown-gem', '2.0.0', 'https://example.com/unknown-gem', 'A gem without a license.', 'unknown']
        ]
      end
    end

    it 'reports gems without a guessable license' do
      Dir.mktmpdir do |dir|
        expect { Rake::Task['gem:licenses:csv'].invoke(File.join(dir, 'licenses.csv')) }.to output(
          a_string_including('IMPORTANT: You have 1 projects without a guessable license!')
        ).to_stdout
      end
    end

    it 'fails with a usage message without a filename' do
      expect { Rake::Task['gem:licenses:csv'].invoke }.to raise_error(SystemExit).and output(
        "Missing CSV filename, run rake gem:licenses:csv[licenses.csv].\n"
      ).to_stderr
    end
  end

  describe 'gem:licenses:copyrights:csv' do
    before do
      allow(mit_gem).to receive(:copyrights).and_return(['2019 Jane Doe', '2020 Example Corp'])
      allow(unknown_gem).to receive(:copyrights).and_return([])
    end

    it 'writes gems, licenses, and copyrights to the CSV file' do
      Dir.mktmpdir do |dir|
        filename = File.join(dir, 'copyrights.csv')
        expect { Rake::Task['gem:licenses:copyrights:csv'].invoke(filename) }.to output(
          a_string_including('Written licenses and copyrights for 2 project(s).')
        ).to_stdout
        expect(CSV.read(filename)).to eq [
          %w[name version homepage summary license copyright],
          ['mit-gem', '1.0.0', 'https://example.com/mit-gem', 'An MIT gem.', 'MIT', '2019 Jane Doe; 2020 Example Corp'],
          ['unknown-gem', '2.0.0', 'https://example.com/unknown-gem', 'A gem without a license.', 'unknown', '']
        ]
      end
    end

    it 'fails with a usage message without a filename' do
      expect { Rake::Task['gem:licenses:copyrights:csv'].invoke }.to raise_error(SystemExit).and output(
        "Missing CSV filename, run rake gem:licenses:copyrights:csv[copyrights.csv].\n"
      ).to_stderr
    end
  end
end
