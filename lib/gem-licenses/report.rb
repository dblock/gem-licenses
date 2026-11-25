# frozen_string_literal: true

require 'csv'

module Gem
  module GemLicenses
    # Formats Gem.licenses as text or CSV for the Rake tasks and the command-line interface.
    module Report
      CSV_HEADERS = %w[name version homepage summary license].freeze

      def self.text(licenses, out = $stdout)
        licenses.sort_by { |license, gems| [-gems.count, license] }.each do |license, gems|
          out.puts license.to_s, '=' * license.length
          gems.sort_by(&:name).each { |gem| out.puts describe(gem), gem.full_gem_path }
          out.puts ''
        end
      end

      def self.csv(licenses, filename, out = $stdout)
        out.puts "Writing #{filename} ..."
        rows = csv_rows(licenses)
        CSV.open(filename, 'w') { |csv| ([CSV_HEADERS] + rows).each { |row| csv << row } }
        names = licenses.keys.sort.join(', ')
        out.puts "Written #{licenses.keys.count} license(s) for #{rows.count} project(s): #{names}"
        unknown(licenses, out)
      end

      def self.unknown(licenses, out = $stdout)
        return unless licenses.key?('unknown')

        out.puts "IMPORTANT: You have #{licenses['unknown'].count} projects without a guessable license!"
        licenses['unknown'].sort_by(&:name).each { |gem| out.puts "  #{gem.name}: #{gem.full_gem_path}" }
      end

      def self.describe(gem)
        "* #{gem.name} #{gem.version} (#{gem.homepage}) - #{gem.summary.to_s.strip}"
      end

      def self.csv_rows(licenses)
        licenses.sort.flat_map do |license, gems|
          gems.sort_by(&:name).map { |gem| [gem.name, gem.version, gem.homepage, gem.summary.to_s.strip, license] }
        end
      end
    end
  end
end
