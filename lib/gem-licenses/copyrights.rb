# frozen_string_literal: true

module Gem
  module GemLicenses
    # Collects copyright lines from a gem's license, notice, and readme files; included into Gem::Specification.
    module Copyrights
      COPYRIGHT_FILES = /license|licence|copying|copyright|notice|readme/i.freeze

      # A copyright line starts with "Copyright" or "©", optionally surrounded by "(c)" or "©", and names
      # its holder; prose such as "Copyright notice" and template placeholders such as "[year]" are skipped.
      COPYRIGHT_REFERENCE = /
        \A(?:\(c\)\s*)?(?:copyright|©)(?>(?:\s*(?:\(c\)|©))?)\s+
        (?!(?:notices?|owners?|holders?|licen[cs]es?|of|on|and|statements?|laws?)\b|[\[{<])
        (?<c>\S.*)
      /ix.freeze

      def copyrights
        copyrights = []
        Dir.children(full_gem_path).sort.each do |filename|
          path = File.join(full_gem_path, filename)
          next unless File.file?(path) && File.basename(filename, File.extname(filename)).match?(COPYRIGHT_FILES)

          copyrights.concat(copyrights_from_file(path))
        end
        copyrights.uniq
      rescue Errno::ENOENT => e
        warn "gem-licenses: #{e.message}."
        []
      end

      private

      def copyrights_from_file(path)
        File.foreach(path).filter_map do |line|
          match = COPYRIGHT_REFERENCE.match(line.strip.sub(/\A#+\s*/, ''))
          match['c'].strip if match
        end
      rescue StandardError => e
        warn "gem-licenses: cannot read #{path}: #{e.message}."
        []
      end
    end
  end

  class Specification
    include GemLicenses::Copyrights
  end
end
