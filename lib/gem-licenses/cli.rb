# frozen_string_literal: true

require 'optparse'

module Gem
  module GemLicenses
    # The gem-licenses command, which reports the licenses of the gems in a project's bundle.
    class CLI
      class Error < StandardError; end

      BANNER = <<~TEXT
        Usage: gem-licenses [options]

        Lists the licenses of the gems in a project's bundle.

      TEXT

      OPTIONS = [
        [:gemfile, '--gemfile PATH', 'Gemfile of the project, default: BUNDLE_GEMFILE or ./Gemfile.'],
        [:csv, '--csv FILE', 'Write gems and licenses to a CSV file instead of listing them.'],
        [:strict, '--strict', 'Exit with status 1 when a gem has no guessable license.'],
        [:version, '-v', '--version', 'Show the version.'],
        [:help, '-h', '--help', 'Show this help.']
      ].freeze

      def self.start(argv = ARGV)
        exit new.run(argv)
      end

      def initialize(out: $stdout, err: $stderr)
        @out = out
        @err = err
      end

      def run(argv)
        options = parse(argv.dup)
        return info(options) if options[:help] || options[:version]

        report(options, bundle_specs(options[:gemfile]))
      rescue OptionParser::ParseError, Error => e
        @err.puts "gem-licenses: #{e.message.chomp('.')}.", 'Run gem-licenses --help for usage.'
        2
      end

      private

      def parse(argv)
        options = {}
        @parser = OptionParser.new do |opts|
          opts.banner = BANNER
          OPTIONS.each { |key, *args| opts.on(*args) { |value| options[key] = value } }
        end
        @parser.parse!(argv)
        raise Error, "unexpected argument: #{argv.first}" unless argv.empty?

        options
      end

      def info(options)
        @out.puts options[:help] ? @parser.help : "gem-licenses #{VERSION}"
        0
      end

      def report(options, specs)
        licenses = Gem.licenses(specs)
        if options[:csv]
          Report.csv(licenses, File.expand_path(options[:csv]), @out)
        else
          Report.text(licenses, @out)
        end
        options[:strict] && licenses.key?('unknown') ? 1 : 0
      end

      # Reports only the gems in the project's bundle, not every gem loaded in this process. Under bundle exec,
      # Bundler has already set up the project's bundle; otherwise, set up the project's Gemfile.
      def bundle_specs(gemfile)
        setup_bundle(gemfile) unless gemfile.nil? && bundled?
        Bundler.load.specs.to_a
      end

      def setup_bundle(gemfile)
        gemfile = File.expand_path(gemfile || ENV.fetch('BUNDLE_GEMFILE', 'Gemfile'))
        raise Error, "no Gemfile at #{gemfile}" unless File.file?(gemfile)

        ENV['BUNDLE_GEMFILE'] = gemfile
        require 'bundler'
        Bundler.setup
      rescue Bundler::BundlerError => e
        raise Error, "could not load #{gemfile}: #{e.message}"
      end

      def bundled?
        defined?(Bundler) && ENV.key?('BUNDLE_GEMFILE')
      end
    end
  end
end
