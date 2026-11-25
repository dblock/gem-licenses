# frozen_string_literal: true

require 'spec_helper'
require 'rake'

describe Gem::GemLicenses do
  before do
    Rake.application = Rake::Application.new
  end

  after do
    Rake.application = Rake::Application.new
  end

  describe '.install_tasks' do
    it 'loads the Rake tasks' do
      described_class.install_tasks
      expect(Rake::Task.task_defined?('gem:licenses')).to be true
      expect(Rake::Task.task_defined?('gem:licenses:csv')).to be true
    end

    it 'loads the Rake tasks only once' do
      2.times { described_class.install_tasks }
      expect(Rake::Task['gem:licenses'].actions.size).to eq 1
    end
  end

  describe 'Railtie' do
    let(:railtie_class) do
      Class.new do
        def self.rake_tasks(&block)
          @rake_tasks = block
        end

        def self.run_rake_tasks
          @rake_tasks.call
        end
      end
    end

    before do
      stub_const('Rails::Railtie', railtie_class)
      load File.expand_path('../../lib/gem-licenses/railtie.rb', __dir__)
    end

    after do
      Gem::GemLicenses.send(:remove_const, :Railtie)
    end

    it 'loads the Rake tasks into Rails' do
      Gem::GemLicenses::Railtie.run_rake_tasks
      expect(Rake::Task.task_defined?('gem:licenses')).to be true
    end
  end
end
